####
# INTERACTIVE SESSION DETECTION
##

set -gx SESSION_TYPE

if begin set -q SSH_CLIENT; or set -q SSH_TTY; or set -q SSH_CONNECTION; or ps -p %self | grep ssh; end
  echo "Detected remote ssh session..."
  set -a SESSION_TYPE remote
else
  set -a SESSION_TYPE local
end

if status is-login
  echo "Detected login shell session..."
  set -a SESSION_TYPE login
  if not status is-interactive
    test -q mise; and mise activate fish --shims | source
  end
end

if status is-interactive
  echo "Detected interactive shell session..."
  set -a SESSION_TYPE interactive
  test -q mise; and mise activate fish | source
end

####
# CONFIG
###

# LOCATION
if not set -q XDG_CONFIG_HOME;
  set -gx XDG_CONFIG_HOME "$HOME/.config"
end
set -gx CONFIG_ROOT $XDG_CONFIG_HOME

# HOMEBREW
set -gx HOMEBREW_NO_AUTO_UPDATE 1
eval "$(/opt/homebrew/bin/brew shellenv)"

# ELIXIR
set -gx MIX_HOME $HOME/.mix
set -gx ERL_AFLAGS "-kernel shell_history enabled -kernel shell_history_file '.iex_history'"

# ERLANG
set -gx ERL_FLAGS "+B"
set -gx KERL_BUILD_DOCS "yes"
set -gx KERL_CONFIGURE_OPTIONS "--without-javac --without-odbc --with-ssl=$(brew --prefix openssl@3)"

# FLY.IO

set -gx FLY_HOME $HOME/.fly

# POSTGRES
set -gx PGDATABASE postgres
set -gx PGUSER postgres
set -gx PSQL_ROOT $CONFIG_ROOT/psql
set -gx PSQLRC $PSQL_ROOT/psqlrc


####
# PATHS
##

set -l paths

set paths -a "/usr/local/bin" $paths
set paths -a "/usr/local/sbin" $paths
set paths -a $HOME/.local/bin $paths

# brew uconv
set paths -a "$(brew --prefix icu4c)/bin" $paths

# FLY.IO

set paths -a $FLY_HOME/bin $paths

# Personal binaries
set paths -a $HOME/bin $paths

# ELIXIR
set paths -a $MIX_HOME/escripts $paths
# make-like build tool for ML deps
set paths -a $HOME/.bazel/bin $paths

# PATH

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

set -gx LDFLAGS ""
set -gx LDFLAGS "$LDFLAGS -L$(brew --prefix openssl)/lib"
set -gx LDFLAGS "$LDFLAGS -L$(brew --prefix icu4c)/lib"

set -gx CPPFLAGS ""
set -gx CPPFLAGS "$CPPFLAGS -I$(brew --prefix openssl)/include"
set -gx CPPFLAGS "$CPPFLAGS -I$(brew --prefix icu4c)/include"

set -gx PKG_CONFIG_PATH "$(brew --prefix pkgconfig)"
set -gx PKG_CONFIG_PATH "$PKG_CONFIG_PATH:$(brew --prefix icu4c)/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "$PKG_CONFIG_PATH:$(brew --prefix curl)/lib/pkgconfig"
set -gx PKG_CONFIG_PATH "$PKG_CONFIG_PATH:$(brew --prefix zlib)/lib/pkgconfig"

####
# FISH
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
