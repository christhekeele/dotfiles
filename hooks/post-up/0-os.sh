#!/usr/bin/env bash
set -e
set -x

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME-$HOME/.config}
export CONFIG_DIR=$XDG_CONFIG_HOME
mkdir -p $HOME/.config

case "$(uname -sr)" in

  Darwin*)
    echo "Running post-setup steps for OSX..."

    echo "Installing Homebrew system package manager..."
    set +e
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 2>&1
    set -e

    echo "Installing Hombrew packages..."
    brew bundle install --file $HOME/.Brewfile --no-lock > /dev/null 2>&1
  ;;

  Linux*Microsoft*)
    echo "Running post-setup steps for WSL..."
  ;;

  Linux*)
    echo "Running post-setup steps for Linux..."
    
    echo "Updating apt-get system package installer..."
    sudo apt-get -y update > /dev/null 2>&1

    echo "Installing essentials..."
    sudo apt-get -y install build-essential > /dev/null 2>&1
    sudo apt-get -y install unzip > /dev/null 2>&1
    
    echo "Installing fish shell..."
    sudo add-apt-repository -y ppa:fish-shell/release-3
    sudo apt-get -y update > /dev/null 2>&1
    sudo apt-get -y install fish > /dev/null 2>&1
    chsh vagrant -s /usr/bin/fish
  ;;

  CYGWIN*|MINGW*|MINGW32*|MSYS*)
    echo "Running post-setup steps for Windows..."
  ;;

  *)
    echo "Running post-setup steps for unidentified OS..."
  ;;
esac