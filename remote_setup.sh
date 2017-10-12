#!/usr/bin/env bash

if [ -z "$CMD" ]; then
  echo "No curl or wget available"
  echo "Aborting"
else
  echo "Beginning remote install"
  mkdir -p "$HOME/dotfiles" && \
  eval "$CMD https://github.com/louisscruz/dotfiles/tarball/master | tar -xzv -C ~/.dotfiles --strip-components=1 --exclude='{.gitignore}'"
  . "$HOME/dotfiles/setup.sh"
fi
