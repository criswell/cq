#!/bin/bash

unset BINPATH UNINSTALL || true

# Installation manifests
MANIFEST_BIN=(
`cq`
`cq-init`
)

#########################
# MAIN ENTRY POINT
#########################

PROGNAME=${0##*/}

usage()
{
  cat <<EOF

  Usage: $PROGNAME [OPTION]
  Where [OPTION] is one of the following:

  --bin=BINPATH/        Installs to BINPATH/ (defaults to '~/bin')

  --uninstall           Uninstall

  --help                Display this help message.

  If no options specified, will install to the default directory.
EOF
}

for i in "$@"
do
  case $i in
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
    *)
      usage
      exit 1
      shift
      ;;
  esac
done

[ -n "$BINPATH" ] || BINPATH=~/bin

