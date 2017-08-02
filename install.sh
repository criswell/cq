#!/bin/bash

unset LIBPATH BINPATH QUIET UNINSTALL || true

# Shell color settings
COLOR_RESET='\033[0m'
COLOR_TRACE='\033[0;34m' # Blue
COLOR_WARNING='\033[1;33m' # Yellow
COLOR_ALERT='\033[4;31m' # Underline red
COLOR_DIE='\033[30m\033[41m' # Red background, black text

# Installation manifests
MANIFEST_LIB=(
'common.sh'
'import.sh'
'output.sh'
'usage.sh'
'config.sh'
'init.sh'
'logic.sh'
)

MANIFEST_BIN=(
'git-cq'
)

########################
# HELPER FUNCTIONS
########################

# Trace functions
inner_trace () {
  if [ -n "$LOGFILE" ]; then
    echo -e "$(date) $*" >> ${LOGFILE}
  else
    echo -e "$*"
  fi
}

warning () {
  if [ -n "$LOGFILE" ]; then
    inner_trace "$*"
  else
    [ -n "$QUIET" ] || inner_trace "${COLOR_WARNING}$*${COLOR_RESET}"
  fi
}

trace () {
  if [ -n "$LOGFILE" ]; then
    inner_trace "$*"
  else
    [ -n "$QUIET" ] || inner_trace "${COLOR_TRACE}$*${COLOR_RESET}"
  fi
}

alert() {
  if [ -n "$LOGFILE" ]; then
    inner_trace "$*"
  else
    inner_trace "${COLOR_ALERT}$*${COLOR_RESET}"
  fi
}

die() {
  if [ -n "$LOGFILE" ]; then
    inner_trace "$*"
  else
    inner_trace "${COLOR_DIE}$*${COLOR_RESET}"
  fi
  exit 1
}

# Installer functions
_remove() {
  if [ -f "$*" ]; then
    unlink $*
  else
    warning "Unable to unlink '$*'"
  fi
}

install_cq() {
  if [ -x "$LIBPATH/cq_install.sh" ]; then
    trace "Previouse cq install found, uninstalling..."
    bash $LIBPATH/cq_install.sh --uninstall
  fi

  if [ ! -d "$BINPATH" ]; then
    mkdir -p $BINPATH
  fi

  if [ ! -d "$LIBPATH" ]; then
    mkdir -p $LIBPATH
  fi

  trace "Installing cq libraries..."
  for fn in "${MANIFEST_LIB[@]}"
  do
    cp -a lib/$fn $LIBPATH/$fn || alert "Cannot copy '$fn', was installer run from repo directory?"
  done

  trace "Installing cq binaries..."
  for fn in "${MANIFEST_BIN[@]}"
  do
    cp -a bin/$fn $BINPATH/$fn || alert "Cannot copy '$fn', was installer run from repo directory?"
  done
  cp -a install.sh $LIBPATH/cq_install.sh || alert "Cannot copy installer,
  was it run from repo directory?"

  trace "Installation complete..."
  trace "Please make sure that '$BINPATH' is in your \$PATH, and that \$CQLIB_PATH"
  trace "is set in your environment to '$LIBPATH'."
}

uninstall_cq() {
  trace "Removing cq libraries..."
  for fn in "${MANIFEST_LIB[@]}"
  do
    _remove "$LIBPATH/$fn"
  done

  trace "Removing cq binaries..."
  for fn in "${MANIFEST_BIN[@]}"
  do
    _remove "$BINPATH/$fn"
  done

  if [ -x "$LIBPATH/cq_install.sh" ]; then
    _remove "$LIBPATH/cq_install.sh"
  fi
}

#########################
# MAIN ENTRY POINT
#########################

PROGNAME=${0##*/}

usage()
{
  cat <<EOF

  Usage: $PROGNAME [OPTION]
  Where [OPTION] is one of the following:

  --lib=LIBPATH/        Installs the libraries to LIBPATH/
                        (defaults to '~/lib/cq')

  --bin=BINPATH/        Installs to BINPATH/ (defaults to '~/bin')

  --uninstall           Uninstall

  --quiet               Perform operation quietly

  --log=LOGFILE         Log installation to LOGFILE
                        (can also be set as environmental variable
                        "\$LOGFILE")

  --help                Display this help message.

  If no options specified, will install to the default directory.
EOF
}

for i in "$@"
do
  case $i in
    --lib=*)
      LIBPATH="${i#*=}"
      shift
      ;;
    --bin=*)
      BINPATH="${i#*=}"
      shift
      ;;
    -h|--help)
      usage
      exit 0
      shift
      ;;
    --uninstall)
      UNINSTALL=yes
      shift
      ;;
    --quiet)
      QUIET=yes
      shift
      ;;
    --log=*)
      LOGFILE="${i#*=}"
      shift
      ;;
    *)
      usage
      exit 1
      shift
      ;;
  esac
done

[ -n "$LIBPATH" ] || LIBPATH=~/lib/cq
[ -n "$BINPATH" ] || BINPATH=~/bin

if [ -n "$UNINSTALL" ]; then
  trace "Uninstalling cq..."
  trace " "
  uninstall_cq

  trace "Done uninstalling"
  exit 0
fi

install_cq

