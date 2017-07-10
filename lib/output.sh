# Output library
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

# Shell color settings
COLOR_RESET='\033[0m'
COLOR_TRACE='\033[0;34m' # Blue
COLOR_WARNING='\033[1;33m' # Yellow
COLOR_ALERT='\033[4;31m' # Underline red
COLOR_DIE='\033[30m\033[41m' # Red background, black text

#######################
# HELPER FUNCTIONS
#######################

# Trace functions
warning() {
  echo -e "${COLOR_WARNING}$*${COLOR_RESET}"
}

trace() {
  echo -e "${COLOR_TRACE}$*${COLOR_RESET}"
}

alert() {
  echo -e "${COLOR_ALERT}$*${COLOR_RESET}"
}

die() {
  echo -e "${COLOR_DIE}$*${COLOR_RESET}"
  exit 1
}

debug() {
  if [ -n "$VERBOSE" ]; then
    echo -e "${COLOR_WARNING}DEBUG: ${COLOR_TRACE}$*${COLOR_RESET}"
  fi
}
