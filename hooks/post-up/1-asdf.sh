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
set +x

asdf plugin add awscli > /dev/null 2>&1
asdf plugin add imagemagick > /dev/null 2>&1
asdf plugin add jq > /dev/null 2>&1
asdf plugin add shellcheck > /dev/null 2>&1
asdf plugin add shfmt > /dev/null 2>&1
asdf plugin add terraform > /dev/null 2>&1

asdf plugin add elixir > /dev/null 2>&1
asdf plugin add erlang > /dev/null 2>&1
asdf plugin add golang > /dev/null 2>&1
asdf plugin add java > /dev/null 2>&1
asdf plugin add lua > /dev/null 2>&1
asdf plugin add nodejs > /dev/null 2>&1
asdf plugin add python > /dev/null 2>&1
asdf plugin add ruby > /dev/null 2>&1
asdf plugin add rust > /dev/null 2>&1

asdf plugin add mongodb > /dev/null 2>&1
asdf plugin add mysql > /dev/null 2>&1
asdf plugin add postgres > /dev/null 2>&1
asdf plugin add rabbitmq > /dev/null 2>&1
asdf plugin add redis > /dev/null 2>&1
asdf plugin add sqlite > /dev/null 2>&1


echo "Installing asdf packages..."
set -x
asdf install > /dev/null 2>&1