#
# Executes commands at the start of an interactive session.
#
# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Enable advanced file moves
autoload -U zmv
alias mvz='noglob zmv -W'

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
alias irb='irb --simple-prompt'

# JS

alias nvm='nocorrect nvm'
alias node='nocorrect node'
alias yarn='nocorrect yarn'

# VAGRANT

alias vagrant='nocorrect vagrant '

# ELIXIR

alias miex="iex -S mix"

# GO

alias go='nocorrect go '

# SHELL

alias loc="cloc . --exclude-lang=Javascript,HTML,CSS,YAML,Bourne\ Shell"

if [[ $OSTYPE == 'darwin'* ]]; then

  alias date="nocorrect gdate"

  # source $(brew --prefix nvm)/nvm.sh

  alias chrome="nocorrect open -a \"Google Chrome\""

  notify() { osascript -e "display notification \"${1:-Finished}\" with title \"${2:-Note}\" subtitle \"$3\"" }
  report() { "$@"; result=$?; [ $result -eq 0 ] && notify "$*" Succeeded || notify "$*" Failed; return $result }

fi

# UNALIAS

# Christ this was a bad idea, zprezto.
# From .zprezto/modules/utility/init.zsh:129
unalias get
