#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# better probing of aliases
alias which="type -a "

# TYPOS

alias -g isntall="install"

# GIT

alias gi='git'

# RUBY

alias rake='nocorrect rake '
alias rails='nocorrect rails '
alias spring='nocorrect spring '
alias guard='nocorrect guard '
alias rspec='nocorrect rspec '
alias bundle='nocorrect bundle '
alias pry='nocorrect pry '
alias powder='nocorrect powder '

# HEROKU BINSTUBS

alias dev='nocorrect dev '
alias qa='nocorrect qa '
alias stage='nocorrect stage '
alias prod='nocorrect prod '
alias demo='nocorrect demo '

# VAGRANT

alias vagrant='nocorrect vagrant '

# RUBY

alias irb='irb --simple-prompt'

# ELIXIR

alias miex="iex -S mix"

# GO

alias go='nocorrect go '

# NODE

export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh
# alias npm-exec='PATH=$(npm bin):$PATH'

# POSTGRES

export PGDATA=/usr/local/var/postgres

# SHELL

alias loc="cloc . --exclude-lang=Javascript,HTML,CSS,YAML,Bourne\ Shell"

if [[ $OSTYPE == 'darwin'* ]]; then
  source $(brew --prefix nvm)/nvm.sh

  alias chrome="nocorrect open -a \"Google Chrome\""

  notify() { osascript -e "display notification \"${1:-Finished}\" with title \"${2:-Note}\" subtitle \"$3\"" }
  report() { "$@"; result=$?; [ $result -eq 0 ] && notify "$*" Succeeded || notify "$*" Failed; return $result }

  mps() { ps -eo comm,pid | grep -v "grep" | grep $2 }
  mkill() { mps $1 | cut -f2 -d '|' | xargs kill -9 }
fi
