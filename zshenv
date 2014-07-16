#
# Defines environment variables.
#

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

export SHELL=/bin/zsh

export HISTSIZE=10000

export LOCAL=true

export RBENV_ROOT=/usr/local/var/rbenv
#export PATH=~/.rbenv/shims:$PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export EXENV_ROOT=/usr/local/var/exenv
#export PATH=~/.exenv/shims:$PATH
if which exenv > /dev/null; then eval "$(exenv init zsh -)"; fi

export PATH=./bin:$PATH

export PIP_ALLOW_EXTERNAL='python-geohash pubnub'
export PIP_ALLOW_UNVERIFIED='python-geohash pubnub'
export PIP_EXTRA_INDEX_URL='https://pypi.python.org/simple'
export PIP_INDEX_URL='https://pypi.fury.io/kFgU6yiKt7YV4PE2Cm6w/localmed/'

export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

if [[ $OSTYPE == 'darwin'* ]]; then
  export ATOM_PATH=/Users/keele/Applications/
fi
