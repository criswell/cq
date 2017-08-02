set -e

# Misc. helper
VERSION=20170712

# Commands
unset CMD_HELP CMD_INIT || true

# Toggles & settings
unset VERBOSE || true

# Parameters
declare -a OPTIONS
PARAMETERS=()

# Determines if an executable exists and is on path
exec_exists() {
  hash $* 2>/dev/null
}

# Check if an option is in the options
has_option() {
  # Okay, so, associative arrays would have been lovely here, but fuck if I
  # couldn't get it to work right. So, I went with this, which is ugly but
  # works
  local _found=1
  for i in "${!OPTIONS[@]}"
  do
    if [[ "$*" == $i ]]; then
      _found=0
    fi
  done
  return $_found
}

# Check if directory is git repo
is_git_repo()
{
  return $(git -C $# rev-parse)
}
