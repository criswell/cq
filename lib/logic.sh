# Main logic

import "common.sh"
import "config.sh"

_get_first_hash()
{
  local _rp=$*
  cd $_rp
  return $(printf '' | git hash-object -t tree --stdin)
}

main_logic()
{
  if has_option "-p"; then
    _repo_path=o
  fi
}
