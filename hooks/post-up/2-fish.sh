#!/usr/bin/env bash
set -e
set -x

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME-$HOME/.config}
export CONFIG_DIR=$XDG_CONFIG_HOME
mkdir -p $HOME/.config > /dev/null 2>&1

echo "Setting fish as our shell..."
if ! grep -q fish $(echo $SHELL); then
  if ! grep -q fish "/etc/shells"; then
    which fish | sudo tee -a /etc/shells > /dev/null 2>&1
  fi
  sudo chsh -s $(which fish) $USER > /dev/null 2>&1
fi
