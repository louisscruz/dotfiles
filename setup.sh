#!/bin/bash

app_installed() {
  system_profiler SPApplicationsDataType | grep $1 >/dev/null
}

already_installed() {
  echo "$1 is already installed"
}

attempting_install() {
  echo ""
  echo "Attempting to install $1..."
}

alert_installed() {
  echo "$1 is now installed"
}

# Installation methods

install_iterm() {
  local app_name=iTerm check_sum=720eccece544ae8765f91c4c0348bb2819e47a2b794ce0adabc14934c00fee38
  attempting_install iTerm
  if ! app_installed "$app_name"; then
    curl -o ~/Downloads/iTerm2-3_1_2.zip https://iterm2.com/downloads/stable/iTerm2-3_1_2.zip
    VAREE=$(shasum -a 256 ~/Downloads/iTerm2-3_1_2.zip)
    # Check that the file has not been altered
    if [[ $VAREE == "$check_sum"* ]]; then
      unzip ~/Downloads/iTerm2-3_1_2.zip
      mv iTerm.app/ /Applications/
      rm ~/Downloads/iTerm2-3_1_2.zip
      echo "Successfully installed iTerm"
      spctl --add /Applications/iTerm.app/
      nohup open /Applications/iTerm.app/ &>/dev/null &
    else
      echo "The checksum for $app_name was invalid!"
    fi
  else
    already_installed "$app_name"
  fi
}

install_homebrew() {
  attempting_install Homebrew
  if which brew >/dev/null; then
    already_installed Homebrew
  else
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

config_git() {
  echo "Please enter your name:"
  read git_full_name
  echo "Please enter your git email:"
  read git_email
  git config --global user.name "$git_full_name"
  git config --global user.email "$git_email"
  git config --global credential.helper osxkeychain
}

install_git() {
  attempting_install git
  if which git >/dev/null; then
    already_installed git
  else
    brew install git
    git --version
    alert_installed Git
    config_git
  fi
}

install_atom() {
  attempting_install Atom
  if which atom >/dev/null; then
    already_installed Atom
  else
    curl -fsSLo ~/Downloads/atom_download.zip https://github.com/atom/atom/releases/download/v1.21.0/atom-mac.zip
    unzip -d ~/Applications/ ~/Downloads/atom_download.zip
  fi
}

# =========================
# Beginning of installation
# =========================

echo "Dotfiles are now running..."

install_iterm
install_homebrew
install_git
install_atom
