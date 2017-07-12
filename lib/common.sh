set -e

# Misc. helper
VERSION=20170712

# Commands
unset CMD_HELP CMD_INIT || true

# Toggles & settings
unset VERBOSE || true

# Parameters
OPTIONS=()
PARAMETERS=()

# Determines if an executable exists and is on path
exec_exists() {
  hash $* 2>/dev/null
}
