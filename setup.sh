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

ensure_bashrc() {
  if [[ ! -f ~/.bashrc ]]; then
    touch ~/.bashrc
    echo "~/.bashrc added"
  else
    echo "~/.bashrc already existed"
  fi
}

ensure_bash_profile() {
  if [[ ! -f ~/.bash_profile ]]; then
    touch ~/.bash_profile
    echo "~/.bash_profile added"
  else
    echo "~/.bash_profile already existed"
  fi
}

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
    alert_installed Homebrew
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
  attempting_install Git
  if which git >/dev/null; then
    already_installed Git
  else
    brew install git
    git --version
    alert_installed Git
    config_git
  fi
}

install_nvm() {
  attempting_install NVM
  if which nvm >/dev/null; then
    already_installed NVM
  else
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.5/install.sh | bash
    source ~/.bash_profile
    alert_installed NVM
  fi
}

install_node() {
  install_nvm
  if which node >/dev/null; then
    already_installed Node
  else
    nvm install node
    nvm use node
    alert_installed Node
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

install_bundler() {
  attempting_install Bundler
  if which bundle >/dev/null; then
    already_installed Bundler
  else
    gem install bundler
    alert_installed Bundler
  fi
}

install_rbenv() {
  attempting_install rbenv
  if which rbenv >/dev/null; then
    already_installed rbenv
  else
    brew install rbenv
    rbenv init
    source ~/.bashrc
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash
    alert_installed rbenv
  fi

  rbenv install 2.4.1
  rbenv install mruby-1.2.0
  rbenv global 2.4.1
}

install_rubocop() {
  attempting_install RuboCop
  if which rubocop >/dev/null; then
    already_installed RuboCop
  else
    gem install rubocop
    alert_installed RuboCop
  fi
}

install_linter() {
  attempting_install Linter
  apm install linter
  alert_installed Linter
}

install_eslint() {
  attempting_install ESLint
  apm install linter-eslint
  alert_installed ESLint
}

install_react() {
  attempting_install Atom\ React
  apm install react
  alert_installed Atom\ React
}

install_atom_packages() {
  attempting_install Atom\ Packages
  install_rubocop
  install_linter
  install_eslint
  install_react
}

# =========================
# Beginning of installation
# =========================

echo "Dotfiles are now running..."

ensure_bash_profile
source ~/.bashrc

ensure_bash_profile
source ~/.bash_profile

install_iterm
install_homebrew
install_bundler
install_rbenv
install_node
install_atom
install_atom_packages
