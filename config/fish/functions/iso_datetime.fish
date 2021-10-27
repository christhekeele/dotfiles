function iso_datetime
  argparse 'd/date=?' 't/time=?' 'z/timezone=?' -- $argv
  
  set -q _flag_time; or set -l _flag_time (iso_time)
  set -q _flag_date; or set -l _flag_date (iso_date)
  set -q _flag_timezone; or set -l _flag_timezone (iso_timezone)

  echo $_flag_date"T"$_flag_time$_flag_timezone
end

