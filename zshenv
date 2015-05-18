#
# Defines environment variables.
#

# Local, non-checked in settings.
if [[ -s "${ZDOTDIR:-$HOME}/.zshlocal" ]]; then
  source "${ZDOTDIR:-$HOME}/.zshlocal"
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export SHELL=/bin/zsh

export HISTSIZE=10000

export EDITOR=vim

export RBENV_ROOT=${RBENV_ROOT:-$HOME/.rbenv}
export PATH=$RBENV_ROOT/bin:$PATH
export PATH=$RBENV_ROOT/shims:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export EXENV_ROOT=${EXENV_ROOT:-$HOME/.exenv}
export PATH=$EXENV_ROOT/bin:$PATH
export PATH=$EXENV_ROOT/shims:$PATH
if which exenv > /dev/null; then eval "$(exenv init zsh -)"; fi

export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

export PATH="/usr/local/heroku/bin:$PATH"

if [[ $OSTYPE == 'darwin'* ]]; then
  export ATOM_PATH=/Users/keele/Applications/
fi

export PATH=./bin:$PATH
