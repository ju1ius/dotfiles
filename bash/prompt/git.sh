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

git_prompt() {
  if ! __git_is_repo
  then
    return 1
  fi

  local prompt=""
  local bgcolor="${bg[green]}"
  local fgcolor="${fg[black]}"

  if __git_is_dirty
  then
    bgcolor="${bg[red]}"
  fi

  prompt+="$(_git_branch)"

  echo -ne "${bgcolor}${fgcolor} ${prompt} ${nocolor}"
}
