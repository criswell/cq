# import library
#
# Copyright (C) 2016  Sam Hart
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

IMPORTS=()

. $CQLIB_PATH/output.sh || echo "ERROR! Unable to load cq libraries (output)!"
IMPORTS+=("output.sh")

_already_imported() {
  local _found=1
  for i in "${IMPORTS[@]}"
  do
    if [[ "$*" == $i ]]; then
      _found=0
    fi
  done
  return $_found
}

dump_imports() {
  for i in "${IMPORTS[@]}"
  do
    echo "$i"
  done
}

import() {
  # We only need to import things once due to bash's globals
  if ! _already_imported "$*"; then
    . $CQLIB_PATH/$* || die "ERROR! Unable to load cq library '$*'!"
    IMPORTS+=("$*")
  fi
}
