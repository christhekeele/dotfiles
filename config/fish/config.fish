#
# Session detection
#
if begin set -q SSH_CLIENT; or set -q SSH_TTY; or ps -p %self | grep ssh; end
  set -gx SESSION_TYPE remote/ssh
else
  set -gx SESSION_TYPE local
end

fish_vi_key_bindings
fish_vi_cursor and if string match -i -r xterm $TERM and __fish_cursor_xterm

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
