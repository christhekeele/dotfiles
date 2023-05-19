#!/usr/bin/env bash
set -e
set -x

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME-$HOME/.config}
export CONFIG_DIR=$XDG_CONFIG_HOME
mkdir -p $HOME/.config > /dev/null 2>&1

echo "Installing asdf tool version manager..."
if [[ ! -d $CONFIG_DIR/asdf ]]; then
  git clone https://github.com/asdf-vm/asdf.git $CONFIG_DIR/asdf --branch v0.11.2 > /dev/null 2>&1
fi

echo "Installing asdf plugins..."

$CONFIG_DIR/asdf/bin/asdf plugin add awscli
$CONFIG_DIR/asdf/bin/asdf plugin add imagemagick
$CONFIG_DIR/asdf/bin/asdf plugin add jq
$CONFIG_DIR/asdf/bin/asdf plugin add shellcheck
$CONFIG_DIR/asdf/bin/asdf plugin add shfmt
$CONFIG_DIR/asdf/bin/asdf plugin add terraform

$CONFIG_DIR/asdf/bin/asdf plugin add elixir
$CONFIG_DIR/asdf/bin/asdf plugin add erlang
$CONFIG_DIR/asdf/bin/asdf plugin add golang
$CONFIG_DIR/asdf/bin/asdf plugin add java
$CONFIG_DIR/asdf/bin/asdf plugin add lua
$CONFIG_DIR/asdf/bin/asdf plugin add nodejs
$CONFIG_DIR/asdf/bin/asdf plugin add python
$CONFIG_DIR/asdf/bin/asdf plugin add ruby
$CONFIG_DIR/asdf/bin/asdf plugin add rust

$CONFIG_DIR/asdf/bin/asdf plugin add mongodb
$CONFIG_DIR/asdf/bin/asdf plugin add mysql
$CONFIG_DIR/asdf/bin/asdf plugin add postgres
$CONFIG_DIR/asdf/bin/asdf plugin add rabbitmq
$CONFIG_DIR/asdf/bin/asdf plugin add redis
$CONFIG_DIR/asdf/bin/asdf plugin add sqlite


echo "Installing asdf packages..."
$CONFIG_DIR/asdf/bin/asdf install java adoptopenjdk-jre-19.0.2+7
$CONFIG_DIR/asdf/bin/asdf install