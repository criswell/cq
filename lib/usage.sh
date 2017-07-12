# usage

import "common.sh"

PROGNAME=${0##*/}

usage_full()
{
  cat <<EOF

  Usage: $PROGNAME [OPTIONS] [COMMAND]

  If called with no COMMAND, will simply display the number of words added
  since midnight of the current day.

  COMMANDS:

    init          Initializes cq

    help          Displays this help, or if a command is specified, will
                  display the help for that command

  OPTIONS:

    -foo          foo bar

EOF
}


