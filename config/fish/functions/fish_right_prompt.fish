function fish_right_prompt --description 'Write out the prompt'

  echo -n -s ' '

  set -l reset_color normal
  set -l background_reset_color normal

  ####
  # GIT INDEX status
  ##
  set -l git_index_badge '❮'

  set -l none_staged_color red
  set -l partially_staged_color yellow
  set -l fully_staged_color green
  set -l nothing_to_stage_color magenta

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1

    # Use git-index color-coded git_index_badges

    ####
    # Index status
    ##

    set -l deletions_staged        0
    set -l deletions_unstaged      0
    set -l deletions_ours          0
    set -l deletions_theirs        0

    set -l additions_staged        0
    set -l additions_unstaged      0
    set -l additions_ours          0
    set -l additions_theirs        0

    set -l modifications_staged    0
    set -l modifications_unstaged  0
    set -l modifications_ours      0
    set -l modifications_theirs    0

    git status --porcelain --ignore-submodules=none | while read --delimiter "\n" -l line

      # Compute deletions
      string match -q -r "^D[\sMT]\s*" $line;          and set -l deletions_staged (math $deletions_staged + 1)
      string match -q -r "^[\sACMRT]D\s*" $line;       and set -l deletions_unstaged (math $deletions_unstaged + 1)
      string match -q -r "^D[DU]\s*" $line;            and set -l deletions_ours (math $deletions_ours + 1)
      string match -q -r "^[DU]D\s*" $line;            and set -l deletions_theirs (math $deletions_theirs + 1)

      # Compute additions
      string match -q -r "^[AC][\sDMT]\s*" $line;      and set -l additions_staged (math $additions_staged + 1)
      string match -q -r "^\?\?\s*" $line;             and set -l additions_unstaged (math $additions_unstaged + 1)
      string match -q -r "^A[AU]\s*" $line;            and set -l additions_ours (math $additions_ours + 1)
      string match -q -r "^[AU]A\s*" $line;            and set -l additions_theirs (math $additions_theirs + 1)

      # Compute modifications
      string match -q -r "^[MRT][\sDMT]\s*" $line;     and set -l modifications_staged (math $modifications_staged + 1)
      string match -q -r "^[\sACMDRT][MRT]\s*" $line;  and set -l modifications_unstaged (math $modifications_unstaged + 1)
      string match -q -r "^U.\s*" $line;               and set -l modifications_ours (math $modifications_ours + 1)
      string match -q -r "^.U\s*" $line;               and set -l modifications_theirs (math $modifications_theirs + 1)

    end

    # Number of all changes
    set -l changes (math $deletions_staged + $deletions_unstaged + $additions_staged + $additions_unstaged + $modifications_staged + $modifications_unstaged)

    # Render deletions
    if test $changes -gt 0
      if test $deletions_staged -gt 0; and test $deletions_unstaged -gt 0
        echo -n -s \
          (set_color $partially_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else if test $deletions_staged -gt 0
        echo -n -s \
          (set_color $fully_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else if test $deletions_unstaged -gt 0
        echo -n -s \
          (set_color $none_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else
        echo -n -s \
          (set_color $nothing_to_stage_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      end
    else
      echo -n -s \
        (set_color $nothing_to_stage_color --dim --background=$background_reset_color)\
        $git_index_badge\
        (set_color $reset_color --background=$background_reset_color)
    end

    # Render additions
    if test $changes -gt 0
      if test $additions_staged -gt 0; and test $additions_unstaged -gt 0
        echo -n -s \
          (set_color $partially_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else if test $additions_staged -gt 0
        echo -n -s \
          (set_color $fully_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else if test $additions_unstaged -gt 0
        echo -n -s \
          (set_color $none_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else
        echo -n -s \
          (set_color $nothing_to_stage_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      end
    else
      echo -n -s \
        (set_color $nothing_to_stage_color --dim --background=$background_reset_color)\
        $git_index_badge\
        (set_color $reset_color --background=$background_reset_color)
    end

    # Render modifications
    if test $changes -gt 0
      if test $modifications_staged -gt 0; and test $modifications_unstaged -gt 0
        echo -n -s \
          (set_color $partially_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else if test $modifications_staged -gt 0
        echo -n -s \
          (set_color $fully_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else if test $modifications_unstaged -gt 0
        echo -n -s \
          (set_color $none_staged_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      else
        echo -n -s \
          (set_color $nothing_to_stage_color --background=$background_reset_color)\
          $git_index_badge\
          (set_color $reset_color --background=$background_reset_color)
      end
    else
      echo -n -s \
        (set_color $nothing_to_stage_color --dim --background=$background_reset_color)\
        $git_index_badge\
        (set_color $reset_color --background=$background_reset_color)
    end

  else
    # Not in a git dir; display static chevrons
    echo -n -s \
      (set_color $nothing_to_stage_color --dim --background=$background_reset_color)\
      $git_index_badge$git_index_badge$git_index_badge\
      (set_color $reset_color --background=$background_reset_color)
  end

  if git rev-parse --is-inside-work-tree > /dev/null 2>&1
    echo -n -s ' '

    ####
    # GIT HEAD status
    ##

    set -l short_sha (git rev-parse -q --short HEAD)
    set -l branch (git branch --show-current)

    if test -n "$branch"
      echo -n -s \
        (set_color cyan --italics --background=$background_reset_color)\
        $branch\
        (set_color $reset_color --background=$background_reset_color)
    else
      echo -n -s (set_color red --bold --italics --background=$background_reset_color)\
      $short_sha\
      (set_color $reset_color --background=$background_reset_color)
    end
  end

  echo -n -s ' '

  ####
  # LAST COMMAND status
  ##

  set -l foreground_status_color white
  set -l background_status_failed_color red
  set -l background_status_succeeded_color $background_reset_color

  # show last command run duration colored by exit code
  if test $status -gt 0
    echo -n -s \
      (set_color $foreground_status_color --background=$background_status_failed_color)\
      (cmd_duration_readable)\
      (set_color $background_reset_color)
  else
    echo -n -s \
      (set_color $foreground_status_color --dim --background=$background_status_succeeded_color)\
      (cmd_duration_readable)\
      (set_color $background_reset_color)
  end
end
