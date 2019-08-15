function fish_mode_prompt --description 'Display the mode for the prompt'

  if test "$fish_key_bindings" = "fish_vi_key_bindings"; or test "$fish_key_bindings" = "fish_hybrid_key_bindings"

    echo -n -s ' '

    switch $fish_bind_mode
    case default
      echo -n -s (set_color --bold cyan)'➣'(set_color normal)' '
    case insert
      echo -n -s (set_color --bold green)'✎ '(set_color normal)
    case replace_one
      echo -n -s (set_color --bold red --background=brblack)'✄ '(set_color normal)
    case visual
      echo -n -s (set_color --bold magenta --background=brblack)'☞ '(set_color normal)
    end

    echo -n -s ' '

  end

end
