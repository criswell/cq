import "common.sh"
import "config.sh"

# Helper for setting config stuff
_set_option()
{
  debug "Setting $1 setting..."
  if config_exists "$1"; then
    if has_option "-f"; then
      trace "Resetting $1 due to 'force' option..."
    else
      die "Unable to set configuration, $1 already set!"
    fi
  fi
  config_set "$1 $2"
}

########################
# MAIN ENTRY POINT
########################
init_cq()
{
  trace "Preparing for first time init..."

  _set_option "defaulttime" "\"midnight\""
  _set_option "defaultwords" "1000"
}
