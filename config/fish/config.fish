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

function fish_prompt --description 'Write out the prompt'
  set -l color_usr
  set -l color_hst
  set -l color_pwd

  contains $USER root toor; and set -q fish_color_root;
    and set color_usr $fish_color_root;
    or  set color_usr $fish_color_user

  set color_hst $fish_color_host

  contains $USER root toor; set -q fish_color_cwd_root;
    and set color_pwd $fish_color_cwd_root;
    or  set color_pwd $fish_color_cwd
  
  set -q SESSION_TYPE; and string match -irq remote $SESSION_TYPE; or contains $USER root toor; and echo -n -s \
    ' '
  set -q SESSION_TYPE; and string match -irq remote $SESSION_TYPE; and echo -n -s \
    (set_color $color_usr) "$USER" (set_color normal)
  contains $USER root toor; and echo -n -s \
    (set_color red --bold) '♛ ' (set_color normal)
  not contains $USER root toor; and set -q SESSION_TYPE; and string match -irq remote $SESSION_TYPE; and echo -n -s \
    (set_color white) '@' (set_color normal)
  set -q SESSION_TYPE; and string match -irq remote $SESSION_TYPE; and echo -n -s \
    (set_color $color_hst) "$HOSTNAME" (set_color normal)
  echo -n -s \
    ' ' \
    (set_color $color_pwd) (prompt_pwd) (set_color normal)
  echo -n -s \
    ' ' \
    (set_color green --bold) '❯❯❯' (set_color normal)
    
  if test "$fish_key_bindings" = "fish_vi_key_bindings"
    or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
    echo -n -s ' '
    switch $fish_bind_mode
    case default
      echo -n -s (set_color 555) '✄ ' (set_color normal)
    case insert
      echo -n -s (set_color 555) '✏ ' (set_color normal)
    case replace-one
      echo -n -s (set_color 555) '➜ ' (set_color normal)
    case visual
      echo -n -s (set_color 555) '❝ ' (set_color normal)
    end
  end
  
  echo -n -s ' '
  
end

function fish_right_prompt --description 'Write out the right prompt'
  set -l git_branch

  set git_branch (git rev-parse --abbrev-ref HEAD 2> /dev/null)
  
  echo -n -s ' '
    
  if test "$fish_key_bindings" = "fish_vi_key_bindings"; or test "$fish_key_bindings" = "fish_hybrid_key_bindings"
    switch $fish_bind_mode
    case visual
      echo -n -s (set_color 555) '❞ ' (set_color normal) \
        ' '
    end
  end

  echo -n -s \
    (set_color magenta) '❮❮❮' (set_color normal) \
    ' '
    
  if test -n "$git_branch"
    echo -n -s \
      (set_color $fish_color_cwd) "$git_branch" (set_color normal) \
      ' '
  end
  
end

function fish_mode_prompt; end
