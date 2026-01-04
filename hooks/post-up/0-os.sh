#!/usr/bin/env bash
set -e
set -x

export XDG_CONFIG_HOME=${XDG_CONFIG_HOME-$HOME/.config}
export CONFIG_DIR=$XDG_CONFIG_HOME
mkdir -p $HOME/.config

case "$(uname -sr)" in

  Darwin*)
    echo "Running post-setup steps for OSX..."
    
    echo "Setting up /etc/sudoers..."
    if sudo cat /etc/sudoers | grep -xqFe 'Defaults	env_keep += "SSH_CLIENT SSH_TTY SSH_CONNECTION SESSION_TYPE"'
    then
      echo "Adding session env vars preservation to /etc/sudoers..."
      echo '' | sudo tee -a /etc/sudoers
      echo '# Preserve session detection env vars when sudoing' | sudo tee -a /etc/sudoers
      echo 'Defaults	env_keep += "SSH_CLIENT SSH_TTY SSH_CONNECTION SESSION_TYPE"' | sudo tee -a /etc/sudoers
    else
      echo "Session env var preservation already set up in /etc/sudoers."
    fi

    echo "Installing Homebrew system package manager..."
    if [[ ! $(which brew) ]]; then
      set +x
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" > /dev/null 2>&1
      set -x
    fi

    echo "Installing Homebrew packages..."
    brew bundle install --file $HOME/.Brewfile > /dev/null 2>&1
  ;;

  Linux*Microsoft*)
    echo "Running post-setup steps for WSL..."
    
    echo "Setting up /etc/sudoers..."
    if sudo cat /etc/sudoers | grep -xqFe 'Defaults	env_keep += "SSH_CLIENT SSH_TTY SSH_CONNECTION SESSION_TYPE"'
    then
      echo "Adding session env vars preservation to /etc/sudoers..."
      echo '' | sudo tee -a /etc/sudoers
      echo '# Preserve session detection env vars when sudoing' | sudo tee -a /etc/sudoers
      echo 'Defaults	env_keep += "SSH_CLIENT SSH_TTY SSH_CONNECTION SESSION_TYPE"' | sudo tee -a /etc/sudoers
    else
      echo "Session env var preservation already set up in /etc/sudoers."
    fi
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
    
    echo "Setting up /etc/sudoers..."
    if sudo cat /etc/sudoers | grep -xqFe 'Defaults	env_keep += "SSH_CLIENT SSH_TTY SSH_CONNECTION SESSION_TYPE"'
    then
      echo "Adding session env vars preservation to /etc/sudoers..."
      echo '' | sudo tee -a /etc/sudoers
      echo '# Preserve session detection env vars when sudoing' | sudo tee -a /etc/sudoers
      echo 'Defaults	env_keep += "SSH_CLIENT SSH_TTY SSH_CONNECTION SESSION_TYPE"' | sudo tee -a /etc/sudoers
    else
      echo "Session env var preservation already set up in /etc/sudoers."
    fi
  ;;

  CYGWIN*|MINGW*|MINGW32*|MSYS*)
    echo "Running post-setup steps for Windows..."
  ;;

  *)
    echo "Running post-setup steps for unidentified OS..."
  ;;
esac