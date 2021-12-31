# shellcheck shell=bash

_prompt.strip_ansi_commands() {
  sed -e 's/\x1B\[[0-9;]*[a-zA-Z]//g' -e 's/\\[][]]//g' <<<"$1"
}

_prompt.align_right() {
  local rhs="$1"
  local stripped="$(_prompt.strip_ansi_commands "$rhs")"
  local -i cols=$(tput cols)
  echo -ne "\[$(tput sc)$(tput cuf "${cols}")$(tput cub ${#stripped})\]${rhs}\[$(tput rc)\]"
}
