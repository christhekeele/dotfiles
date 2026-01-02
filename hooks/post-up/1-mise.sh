#!/usr/bin/env bash
set -e
set -x

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME-$HOME/.config}
export CONFIG_DIR=$XDG_CONFIG_HOME
mkdir -p $HOME/.config > /dev/null 2>&1

echo "Installing mise tools..."

set +e
mise trust ~/.tool-versions
mise install

set -e
