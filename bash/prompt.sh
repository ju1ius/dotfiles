#!/bin/bash

##############################################################################
# A Bash prompt
# Uses default terminal 16-colors (best with OneDark theme)
# Inspired by:
#   * LiquidPrompt github:nojhan/liquidprompt
#   * Bash-It github:bash-it/bash-it
##############################################################################

__FILE__="${BASH_SOURCE[0]}"
__DIR__="$(dirname "$__FILE__")"

##########
# Colors
##########

declare -A fg=(
  ['black']="\[$(tput setaf 0)\]"
  ['red']="\[$(tput setaf 1)\]"
  ['green']="\[$(tput setaf 2)\]"
  ['yellow']="\[$(tput setaf 3)\]"
  ['blue']="\[$(tput setaf 4)\]"
  ['magenta']="\[$(tput setaf 5)\]"
  ['cyan']="\[$(tput setaf 6)\]"
  ['white']="\[$(tput setaf 7)\]"
  ['black2']="\[$(tput setaf 8)\]"
  ['red2']="\[$(tput setaf 9)\]"
  ['green2']="\[$(tput setaf 10)\]"
  ['yellow2']="\[$(tput setaf 11)\]"
  ['blue2']="\[$(tput setaf 12)\]"
  ['magenta2']="\[$(tput setaf 13)\]"
  ['cyan2']="\[$(tput setaf 14)\]"
  ['white2']="\[$(tput setaf 15)\]"
)
declare -A bg=(
  ['black']="\[$(tput setab 0)\]"
  ['red']="\[$(tput setab 1)\]"
  ['green']="\[$(tput setab 2)\]"
  ['yellow']="\[$(tput setab 3)\]"
  ['blue']="\[$(tput setab 4)\]"
  ['magenta']="\[$(tput setab 5)\]"
  ['cyan']="\[$(tput setab 6)\]"
  ['white']="\[$(tput setab 7)\]"
  ['black2']="\[$(tput setab 8)\]"
  ['red2']="\[$(tput setab 9)\]"
  ['green2']="\[$(tput setab 10)\]"
  ['yellow2']="\[$(tput setab 11)\]"
  ['blue2']="\[$(tput setab 12)\]"
  ['magenta2']="\[$(tput setab 13)\]"
  ['cyan2']="\[$(tput setab 14)\]"
  ['white2']="\[$(tput setab 15)\]"
)
nocolor="\[$(tput sgr0)\]"
declare -A style=(
  ['b']="\[$(tput bold)\]"
  ['u']="\[$(tput smul)\]"
  ['/u']="\[$(tput rmul)\]"
  ['inv']="\[$(tput smso)\]"
  ['/inv']="\[$(tput rmso)\]"
)

declare -A colors=(
  ['default_bg']="black2"
  ['default_fg']="white"
  ['error_bg']="red"
  ['error_fg']="black"
  ['success_bg']="green"
  ['success_fg']="black"
  ['login_bg']="magenta"
  ['login_fg']="black"
  ['cwd_bg']="black2"
  ['cwd_fg']="white"
  ['git_clean_bg']="green"
  ['git_clean_fg']="black"
  ['git_dirty_bg']="red"
  ['git_dirty_fg']="black"
  ['git_conflict_bg']="magenta"
  ['git_conflict_fg']="black"
)

##########
# Options
##########

# whether to shorten PWD
PROMPT_SHORTEN_PATH=${PROMPT_SHORTEN_PATH:-1}
# max percentage of the screen taken by PWD
PROMPT_PATH_MAXLEN=${PROMPT_PATH_MAXLEN:-66}
# nunmber of directories to keep at start of PWD
PROMPT_PATH_KEEP=${PROMPT_PATH_KEEP:-2}
# enables detailed git status
PROMPT_ENABLE_GIT_FULLSTATUS=${PROMPT_ENABLE_GIT_FULLSTATUS:-1}
# enable nerd fonts
PROMPT_USE_NERDFONT=${PROMPT_USE_NERDFONT:-0}
PROMPT_NERDFONT_SEP=''
# PROMPT_NERDFONT_SEP=''
# PROMPT_NERDFONT_SEP=''

##########
# Backup
##########
declare -A PROMPT_OLD_SHOPT
declare -A PROMPT_REPLY

# Escape the given strings
# Must be used for all strings injected in PS1 that may comes from remote sources,
# like $PWD, VCS branch names...
_prompt.escape() {
  echo -nE "${1//\\/\\\\}"
}

# source components
source "${__DIR__}/prompt/login.sh"
source "${__DIR__}/prompt/pwd.sh"
source "${__DIR__}/prompt/exit-status.sh"
source "${__DIR__}/prompt/git.sh"
source "${__DIR__}/prompt/text.sh"


# The login part is not supposed to change so we run it just once
PROMPT_LOGIN="$(_prompt.login)"


_prompt.print_component() {
  local content="${PROMPT_REPLY[content]}"
  if [[ -z "${content}" ]]; then
    return 0
  fi

  local outvar="${1:-PS1}"
  local color="${PROMPT_REPLY[color]:-default}"
  local fgc="${colors[${color}_fg]:-default_fg}"
  local bgc="${colors[${color}_bg]:-default_bg}"
  local current_bg="${PROMPT_REPLY[current_bg]}"
  local result=''

  if (( PROMPT_USE_NERDFONT )) && [[ -n "${current_bg}" ]]; then
    printf -v result '%s%s%s' "${fg[$current_bg]}" "${bg[$bgc]}" "${PROMPT_NERDFONT_SEP}"
  fi
  printf -v result '%s%s %s %s' "${result}" "${bg[$bgc]}${fg[$fgc]}" "${content}" "${nocolor}"
  printf -v "${outvar}" '%s%s' "${!outvar}" "${result}"
  PROMPT_REPLY[current_bg]="$bgc"
}


_prompt.end_components() {
  (( ! PROMPT_USE_NERDFONT )) && return 0
  local outvar="${1:-PS1}"
  local current_bg="${PROMPT_REPLY[current_bg]:-${colors[default_bg]}}"
  printf -v result '%s%s%s%s' "${nocolor}" "${fg[$current_bg]}" "${PROMPT_NERDFONT_SEP}" "${nocolor}"
  printf -v "${outvar}" '%s%s' "${!outvar}" "${result}"
  PROMPT_REPLY[current_bg]=""
}


_prompt.set_prompt() {
  # Display the return value of the last command, if different from zero
  # As this gets the last returned code, it should be called first
  local -i exit_code=$?
  PS1=''
  PS2=''
  PROMPT_REPLY=(
    [content]="${PROMPT_LOGIN}"
    [color]='login'
    [current_bg]=''
  )

  _prompt.print_component PS1

  _prompt.git
  _prompt.print_component PS1

  _prompt.pwd
  _prompt.print_component PS1

  _prompt.end_components PS1
  PS1+="\n"

  _prompt.exit_status "${exit_code}"
  _prompt.print_component PS1

  if (( PROMPT_USE_NERDFONT )); then
    _prompt.text ""
    _prompt.print_component PS1
    _prompt.end_components PS1
    PS1+=" "
    _prompt.text ""
    _prompt.print_component PS2
    _prompt.end_components PS2
    PS2+=" "
  else
    PS1+=" ❱ "
    PS2=" ❱❱ "
  fi
}


prompt.on() {
  PROMPT_OLD_PWD=""
  if [[ -z "$PROMPT_OLD_PS1" ]]
  then
    PROMPT_OLD_PS1="$PS1"
    PROMPT_OLD_PROMPT_CMD="$PROMPT_COMMAND"
    PROMPT_OLD_SHOPT=(
      ['promptvars']="$(shopt -p promptvars)"
    )
  fi
  # Disable parameter/command expansion from PS1
  shopt -u promptvars
  # Trap the debug signal to reset colors after entering a command
  trap 'tput sgr0' DEBUG
  # Set the prompt command
  PROMPT_COMMAND=_prompt.set_prompt
}


prompt.off() {
  PS1="$PROMPT_OLD_PS1"
  for opt in "${!PROMPT_OLD_SHOPT[@]}"
  do
    eval "${PROMPT_OLD_SHOPT[$opt]}"
  done
  trap - DEBUG
  PROMPT_COMMAND="$PROMPT_OLD_PROMPT_CMD"
}


prompt.on

unset -v __FILE__
unset -v __DIR__
