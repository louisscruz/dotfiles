#!/bin/bash

app_installed() {
  system_profiler SPApplicationsDataType | grep $1 >/dev/null
}

handle_program_install() {
  if which $1 >/dev/null; then
    echo "installed!"
  else
    echo "not installed!"
  fi
}

already_installed() {
  echo "$1 is already installed"
}

# Install iTerm if it's not aready installed

install_iterm() {
  local app_name=iTerm check_sum=720eccece544ae8765f91c4c0348bb2819e47a2b794ce0adabc14934c00fee38
  if ! app_installed "$app_name"; then
    curl -o ~/Downloads/iTerm2-3_1_2.zip https://iterm2.com/downloads/stable/iTerm2-3_1_2.zip
    VAREE=$(shasum -a 256 ~/Downloads/iTerm2-3_1_2.zip)
    # Check that the file has not been altered
    if [[ $VAREE == "$check_sum"* ]]; then
      echo "a"
      unzip ~/Downloads/iTerm2-3_1_2.zip
      mv iTerm.app/ /Applications/
      rm ~/Downloads/iTerm2-3_1_2.zip
      spctl --add /Applications/iTerm.app/
      nohup open /Applications/iTerm.app/ &>/dev/null &
    else
      echo "The checksum for $app_name was invalid!"
    fi
  else
    already_installed "$app_name"
  fi
}

install_iterm
