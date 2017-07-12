# Configuration wrapper

config_get()
{
  return $(git config --get cq.$*)
}

config_set()
{
  return $(git config cq.$*)
}

config_exists()
{
  local _f=$(git config cq.$*)
  return $?
}
