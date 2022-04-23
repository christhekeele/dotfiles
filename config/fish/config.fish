#
# Session detection
#

if begin set -q SSH_CLIENT; or set -q SSH_TTY; or ps -p %self | grep ssh; end
  set -gx SESSION_TYPE remote/ssh
else
  set -gx SESSION_TYPE local
end


####
# CONFIG
###

# LOCATION
if not set -q XDG_CONFIG_HOME;
  set -gx XDG_CONFIG_HOME "$HOME/.config"
end
set -gx CONFIG_ROOT $XDG_CONFIG_HOME

# VAGRANT
set -gx VAGRANT_HOME $CONFIG_ROOT/vagrant

# HOMEBREW
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# ASDF
set -gx ASDF_ROOT $CONFIG_ROOT/asdf
set -gx ASDF_SOURCE $ASDF_ROOT/asdf.fish
set -gx ASDF_CONFIG_FILE $ASDF_ROOT/config.rc
set -gx ASDF_DATA_DIR $ASDF_ROOT/data
set -gx ASDF_DOWNLOAD_PATH $ASDF_ROOT/downloads

# ELIXIR
set -gx MIX_HOME $HOME/.mix
set -gx ERL_AFLAGS "-kernel shell_history enabled"

# FLY.IO

set -gx FLY_HOME $HOME/.fly

# POSTGRES
set -gx PGDATABASE postgres
set -gx PGUSER postgres
set -gx PSQL_ROOT $CONFIG_ROOT/psql
set -gx PSQLRC $PSQL_ROOT/psqlrc

####
# PATH
##
set -l paths

set paths "/usr/local/bin" $paths
set paths "/usr/local/sbin" $paths

# ASDF

set paths $ASDF_ROOT/bin $paths
set paths $ASDF_DATA_DIR/shims $paths

# FLY.IO

set paths $FLY_HOME/bin $paths

# Personal binaries
set paths $HOME/bin $paths

# ELIXIR
set paths $MIX_HOME/escripts $paths
# make-like build tool for ML deps
set paths $HOME/.bazel/bin $paths

# SnowSQL
set paths '/Applications/SnowSQL.app/Contents/MacOS' $paths

for path in $paths
  if test -e $path
    contains $path $fish_user_paths; or set -Ua fish_user_paths $path
  end
end

# Dir-local binaries
# set -g fish_user_paths './node_modules/.bin' $fish_user_paths
set -g fish_user_paths './exe' $fish_user_paths
set -g fish_user_paths './bin' $fish_user_paths

# Try to shim asdf on every dir navigation
# direnv hook fish | source

####
# COMPILERS
##
set -gx LDFLAGS "-L/usr/local/opt/openssl@1.1/lib"
set -gx CPPFLAGS "-I/usr/local/opt/openssl@1.1/include"

####
# FISH SETUP
##

# VI mode
if status --is-login
  function hybrid_bindings --description "Vi-style bindings that inherit emacs-style bindings in all modes"
      for mode in default insert visual
          fish_default_key_bindings -M $mode
      end
      fish_vi_key_bindings --no-erase
  end
end
set -g fish_key_bindings fish_hybrid_key_bindings

# Colors
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

####
# SOURCE THINGS
##

source $ASDF_SOURCE
