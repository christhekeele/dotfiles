function iso_timezone
  set -l timezone (date +"%z")
  echo (string sub -e -2 -- $timezone)":"(string sub -s -2 -- $timezone)
end