#!/usr/bin/env bash

[[ -x `command -v wget` ]] && CMD="wget --no-check-certificate -O -"
[[ -x `command -v curl` ]] >/dev/null 2>&1 && CMD="curl -#L"

if [ -z "$CMD" ]; then
  echo "No curl or wget available"
  echo "Aborting"
else
  echo "Beginning remote install"
  mkdir -p "$HOME/dotfiles" && \
  eval "$CMD https://github.com/louisscruz/dotfiles/tarball/master | tar -xzv -C ~/.dotfiles --strip-components=1 --exclude='{.gitignore}'"
  . "$HOME/dotfiles/setup.sh"
fi
