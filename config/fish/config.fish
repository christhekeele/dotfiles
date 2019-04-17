#
# Session detection
#

if begin set -q SSH_CLIENT; or set -q SSH_TTY; or ps -p %self | grep ssh; end
  set -gx SESSION_TYPE remote/ssh
else
  set -gx SESSION_TYPE local
end


#
# Bin paths
#

set -gx PATH /usr/local/bin $PATH

set -gx RBENV_ROOT ~/.rbenv
set -gx PATH $RBENV_ROOT/bin $PATH
set -gx PATH $RBENV_ROOT/shims $PATH
status --is-interactive; and source (rbenv init -|psub)

set -gx NODENV_ROOT ~/.nodenv
set -gx PATH $NODENV_ROOT/bin $PATH
set -gx PATH $NODENV_ROOT/shims $PATH
status --is-interactive; and source (nodenv init -|psub)

set -gx PYENV_ROOT ~/.pyenv
set -gx PATH $PYENV_ROOT/bin $PATH
set -gx PATH $PYENV_ROOT/shims $PATH
set -gx PATH ~/.local/bin $PATH
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)

set -gx EXENV_ROOT ~/.exenv
set -gx PATH $EXENV_ROOT/bin $PATH
set -gx PATH $EXENV_ROOT/shims $PATH
status --is-interactive; and source (exenv init -|psub)

set -gx PGENV_ROOT ~/.pgenv
set -gx PATH $PGENV_ROOT/bin $PATH
set -gx PATH $PGENV_ROOT/pgsql/bin $PATH

set -gx MIX_HOME ~/.mix

set -gx ASDF_ROOT $HOME/.config/asdf
set -gx ASDF_DATA_DIR $ASDF_ROOT/plugins
set -gx ASDF_CONFIG_FILE $ASDF_ROOT/config.rc

set -gx PATH $ASDF_ROOT/bin $PATH
set -gx PATH $ASDF_ROOT/shims $PATH

# Personal binaries
set -gx PATH $HOME/bin $PATH
set -gx PATH $MIX_HOME/escripts $PATH

# Dir-local binaries
# set -gx PATH './node_modules/.bin' PATH
set -gx PATH './exe' $PATH
set -gx PATH './bin' $PATH


#
# Colors
#

# set -gx fish_color_autosuggestion     555 brblack
  set -gx fish_color_autosuggestion     555 brblack --italics
# set -gx fish_color_command            --bold
  set -gx fish_color_command            brwhite --bold
# set -gx fish_color_comment            red
  set -gx fish_color_comment            555 brblack --italics
# set -gx fish_color_cwd                green
  set -gx fish_color_cwd                cyan --italics --background=brblack
# set -gx fish_color_cwd_root           normal
  set -gx fish_color_cwd_root           cyan --italics --background=brblack
# set -gx fish_color_end                brmagenta
  set -gx fish_color_end                blue
# set -gx fish_color_error              brred
  set -gx fish_color_error              red --italics
# set -gx fish_color_escape             bryellow --bold
  set -gx fish_color_escape             bryellow --bold
# set -gx fish_color_history_current    --bold
  set -gx fish_color_history_current    --bold --underline
# set -gx fish_color_host               normal
  set -gx fish_color_host               blue --italics
# set -gx fish_color_match              --background=brblue
  set -gx fish_color_match              --underline
# set -gx fish_color_normal             normal
  set -gx fish_color_normal             white
# set -gx fish_color_operator           bryellow
  set -gx fish_color_operator           yellow
# set -gx fish_color_param              cyan
  set -gx fish_color_param              --bold
# set -gx fish_color_quote              yellow
  set -gx fish_color_quote              green --bold
# set -gx fish_color_redirection        brblue
  set -gx fish_color_redirection        brblue --bold --italics
# set -gx fish_color_root               --bold --background=red
  set -gx fish_color_root               magenta --italics --bold
# set -gx fish_color_search_match       bryellow --background=brblack
  set -gx fish_color_search_match       --italics --background=green
# set -gx fish_color_selection          white --bold --background=brblack
  set -gx fish_color_selection          brblack --bold --background=555
# set -gx fish_color_user               brgreen
  set -gx fish_color_user               magenta --italics
# set -gx fish_color_valid_path         --underline
  set -gx fish_color_valid_path         --italics

# set -gx fish_pager_color_description   B3A06D yellow
  set -gx fish_pager_color_description   brmagenta --italics
# set -gx fish_pager_color_prefix        white --bold --underline
  set -gx fish_pager_color_prefix        white --italics
# set -gx fish_pager_color_progress      brwhite --background=cyan
  set -gx fish_pager_color_progress      555 brblack --italics
# unset normally
  set -gx fish_pager_color_completion    brwhite --bold
# set -gx fish_pager_color_secondary     brblack

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /home/keele/projects/knock/apps/lambda/units-service/node_modules/tabtab/.completions/serverless.fish ]; and . /home/keele/projects/knock/apps/lambda/units-service/node_modules/tabtab/.completions/serverless.fish
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /home/keele/projects/knock/apps/lambda/units-service/node_modules/tabtab/.completions/sls.fish ]; and . /home/keele/projects/knock/apps/lambda/units-service/node_modules/tabtab/.completions/sls.fish
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /home/keele/projects/knock/apps/lambda/units-service/node_modules/tabtab/.completions/slss.fish ]; and . /home/keele/projects/knock/apps/lambda/units-service/node_modules/tabtab/.completions/slss.fish
