#
# Defines environment variables.
#

# Don't use system's /etc/zprofile
setopt no_global_rcs
# Instead consume /etc/paths ourselves
export PATH=`grep -vh '^$' /etc/paths.d/* /etc/paths | paste -s -d: -`

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
# Compile opts
export RUBY_CONFIGURE_OPTS="--with-readline-dir=`brew --prefix readline`"

export EXENV_ROOT=${EXENV_ROOT:-$HOME/.exenv}
export PATH=$EXENV_ROOT/bin:$PATH
export PATH=$EXENV_ROOT/shims:$PATH
if which exenv > /dev/null; then eval "$(exenv init zsh -)"; fi

export PATH=$HOME/.mix/escripts:$PATH

export SANDBOX=NONE # For certain rails projects

export NVM_DIR=${NVM_DIR:-$HOME/.nvm}
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

export GOPATH=${GOPATH:-$HOME/.go}
export PATH="$GOPATH/bin:$PATH"

export PATH="/usr/local/heroku/bin:$PATH"

if [[ $OSTYPE == 'darwin'* ]]; then
  export ATOM_PATH=/Applications
fi

# Always look first for project-local binfiles and executables
export PATH=$HOME/bin:$PATH
export PATH=./bin:$PATH
export PATH=./exe:$PATH

export PATH=./node_modules/.bin:$PATH

