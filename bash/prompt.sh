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
  ['black']="$(tput setaf 0)"
  ['red']="$(tput setaf 1)"
  ['green']="$(tput setaf 2)"
  ['yellow']="$(tput setaf 3)"
  ['blue']="$(tput setaf 4)"
  ['magenta']="$(tput setaf 5)"
  ['cyan']="$(tput setaf 6)"
  ['white']="$(tput setaf 7)"
  ['black2']="$(tput setaf 8)"
  ['red2']="$(tput setaf 9)"
  ['green2']="$(tput setaf 10)"
  ['yellow2']="$(tput setaf 11)"
  ['blue2']="$(tput setaf 12)"
  ['magenta2']="$(tput setaf 13)"
  ['cyan2']="$(tput setaf 14)"
  ['white2']="$(tput setaf 15)"
)
declare -A bg=(
  ['black']="$(tput setab 0)"
  ['red']="$(tput setab 1)"
  ['green']="$(tput setab 2)"
  ['yellow']="$(tput setab 3)"
  ['blue']="$(tput setab 4)"
  ['magenta']="$(tput setab 5)"
  ['cyan']="$(tput setab 6)"
  ['white']="$(tput setab 7)"
  ['black2']="$(tput setab 8)"
  ['red2']="$(tput setab 9)"
  ['green2']="$(tput setab 10)"
  ['yellow2']="$(tput setab 11)"
  ['blue2']="$(tput setab 12)"
  ['magenta2']="$(tput setab 13)"
  ['cyan2']="$(tput setab 14)"
  ['white2']="$(tput setab 15)"
)
nocolor="$(tput sgr0)"
declare -A style=(
  ['b']="$(tput bold)"
  ['u']="$(tput smul)"
  ['/u']="$(tput rmul)"
  ['inv']="$(tput smso)"
  ['/inv']="$(tput rmso)"
)

declare -A colors=(
  ['user_root']="${fg[red]}"
  ['user_nologin']="${fg[yellow]}"
  ['host_ssh']="${fg[magenta]}"
  ['host_su']="${fg[yellow]}"
  ['host_telnet']="${fg[red]}"
  ['host_default']="${fg[white]}"
  ['cwd']="${bg[black2]}${fg[white]}"
)

##########
# Options
##########

# whether to shorten PWD
PROMPT_SHORTEN_PATH=${PROMPT_SHORTEN_PATH:-1}
# max percentage of the screen taken by PWD
PROMPT_PATH_MAXLEN=${PROMPT_PATH_MAXLEN:-50}
# nunmber of directories to keep at start of PWD
PROMPT_PATH_KEEP=${PROMPT_PATH_KEEP:-2}
# enables detailed git status
PROMPT_ENABLE_GIT_FULLSTATUS=${PROMPT_ENABLE_GIT_FULLSTATUS:-1}

##########
# Backup
##########
declare -A PROMPT_OLD_SHOPT

# Escape the given strings
# Must be used for all strings injected in PS1 that may comes from remote sources,
# like $PWD, VCS branch names...
_prompt_escape() {
  echo -nE "${1//\\/\\\\}"
}

# source components
source ${__DIR__}/prompt/user.sh
source ${__DIR__}/prompt/host.sh
source ${__DIR__}/prompt/pwd.sh
source ${__DIR__}/prompt/git.sh

_set_prompt() {
  # Display the return value of the last command, if different from zero
  # As this get the last returned code, it should be called first
  local -i error_code=$?
  local prompt_last_error=""
  if (( error_code != 0 ))
  then
    prompt_last_error="\[${bg[red]}${fg[black]}\] $error_code \[$nocolor\]"
  fi

  local conn_str="${PROMPT_USER}${PROMPT_HOST}"
  if [[ -n "$conn_str" ]]; then
    conn_str="${bg[black2]} ${conn_str} ${nocolor}"
  fi

  PS1="${conn_str}"
  PS1+="$(_get_cwd)"
  PS1+="$(git_prompt)"
  PS1+="\n${prompt_last_error}"
  PS1+=" ❱ "

  PS2=" ❱❱ "
}

prompt_on() {
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
  PROMPT_COMMAND=_set_prompt
}

prompt_off() {
  PS1="$PROMPT_OLD_PS1"
  for opt in "${!PROMPT_OLD_SHOPT[@]}"
  do
    eval "${PROMPT_OLD_SHOPT[$opt]}"
  done
  trap - DEBUG
  PROMPT_COMMAND="$PROMPT_OLD_PROMPT_CMD"
}

prompt_on

unset -v __FILE__
unset -v __DIR__
