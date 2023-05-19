#!/usr/bin/env bash
set -e
set -x

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME-$HOME/.config}
export CONFIG_DIR=$XDG_CONFIG_HOME
mkdir -p $HOME/.config

if [[ ! -f $HOME/.rcrc ]]; then
  cp -f $PWD/../../rcrc $HOME/.rcrc
fi
