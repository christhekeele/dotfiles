function fish_prompt --description 'Write out the prompt'

  set last $status

  # Render username
  switch "$USER"
  case root toor # Angry if root
    echo -n -s (set_color red --bold --background=brblack) 'ROOT' (set_color normal)
  case keele # Normal if me
    echo -n -s (set_color magenta --bold --dim) $USER (set_color normal)
  case '*' # Blue if not
    echo -n -s (set_color blue --bold --dim) $USER (set_color normal)
  end

  echo -n -s (set_color white --dim) @ (set_color normal)

  # Render hostname

  set host (prompt_hostname)
  switch "$host"
  case vagrant # Blue if VM
    echo -n -s (set_color blue --bold --dim) 'vagrant' (set_color normal)
  case '*' # Normal if not
    echo -n -s (set_color magenta --bold --dim) $host (set_color normal)
  end

  echo -n -s ' '

  # Render current directory
  echo -n -s (set_color cyan --italics --background=brblack) (prompt_pwd) (set_color normal)

  # Render left chevron buffer
  echo -n -s ' '
  if test $last -gt 0
    echo -n -s (set_color magenta) "❯❯❯" (set_color normal)
  else
    echo -n -s (set_color magenta --dim) "❯❯❯" (set_color normal)
  end
  echo -n -s ' '

end
