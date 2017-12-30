#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/lib/git-helpers.sh"

_git_branch() {
  local -i detached=1
  local branch=""
  if __git_branch &>/dev/null
  then
    branch="$(__git_ref)"
  else
    detached=0
    local prefix=""
    if __git_tag &>/dev/null
    then
      prefix="tag:"
    else
      prefix="detached:"
    fi
    branch="${prefix}$(__git_ref)"
  fi

  echo -ne "${branch}"
}

_git_status() {
  local output=""
  declare -a fields=($(__git_full_status))
  local oid="${fields[0]}"
  local branch="${fields[1]}"
  local -i ahead="${fields[3]}"
  local -i behind="${fields[4]}"
  local -i staged="${fields[5]}"
  local -i unstaged="${fields[6]}"
  local -i untracked="${fields[7]}"
  #TODO: set merge-conflict color if unmerged paths are present
  local -i unmerged="${fields[8]}"

  if [[ "$oid" = "(initial)" ]]; then
    oid="initial"
  else
    # shorten SHA1 to 6 characters
    oid="${oid:0:6}"
  fi
  if [[ "$branch" = "(detached)" ]]; then
    branch="detached($oid)"
  fi
  output+="$branch"

  local upstream_status=""

  if (( ahead > 0 )); then
    upstream_status+="↑${ahead}"
  fi
  if (( behind > 0 )); then
    upstream_status+="↓${behind}"
  fi
  if [[ -n "$upstream_status" ]]; then
    output+=" $upstream_status"
  fi

  local status=""

  if ((staged > 0)); then
    status+="s:${staged}"
  fi
  if ((unstaged > 0)); then
    status+="u:${staged}"
  fi
  if ((untracked > 0)); then
    status+="?${untracked}"
  fi
  if [[ -n "$status" ]]; then
    output+=" $status"
  fi

  echo -ne "$output"
}

git_prompt() {
  if ! __git_is_repo
  then
    return 1
  fi

  local prompt="⎇ "
  local bgcolor="${bg[green]}"
  local fgcolor="${fg[black]}"

  if __git_is_dirty
  then
    bgcolor="${bg[red]}"
  fi

  if (( PROMPT_ENABLE_GIT_STATUS == 1 )); then
    prompt+="$(_git_status)"
  else
    prompt+="$(_git_branch)"
  fi

  echo -ne "${bgcolor}${fgcolor} ${prompt} ${nocolor}"
}
