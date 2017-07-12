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

    -v            Run verbosely

EOF
}

usage_init()
{
	cat <<EOF

	Usage: $PROGNAME [OPTIONS] init

	This will populate the default configuration for cq.

  cq uses git's configuration system for all of its settings. These settings
  can be made globally (in ~/.gitconfig) or locally in a repo's config.

  The 'init' command will populate it with some sensible defaults.

  Rather than explain those defaults here, it's probably best to just run
  init and then edit the configuration accordinly.

  OPTIONS:

    -f          Forces an init to complete, resetting everything to default
                if it already exists

    -v          Run verbosely

EOF
}

############################
# MAIN ENTRY POINT
############################
usage() {
  local _no_command=0
  if [ -n "$CMD_INIT" ]; then
    usage_init
    _no_command=1
  fi

  if [ $_no_command -eq 0 ]; then
    usage_full
  fi
}
