#!/bin/bash

_prompt.git() {
  local status="$(git status --porcelain=2 --branch 2>/dev/null)"
  if [[ -z "$status" ]]; then
    # Probably not inside a repo
    PROMPT_REPLY[content]=''
    return 1
  fi

  local parser="${BASH_SOURCE[0]%/*}/lib/git-parse-status.awk"
  local color="git_clean"

  declare -a fields=($("$parser" <<<"$status"))
  local oid="${fields[0]}"
  local branch="${fields[1]}"
  local -i ahead="${fields[3]}"
  local -i behind="${fields[4]}"
  local -i staged="${fields[5]}"
  local -i unstaged="${fields[6]}"
  local -i untracked="${fields[7]}"
  #TODO: set merge-conflict color if unmerged paths are present
  local -i unmerged="${fields[8]}"

  # ----- Get the status background color:
  # clean: green
  # merge conflicts: magenta
  # dirty: red
  if (( unmerged > 0 )); then
    color="git_conflict"
  elif (( staged > 0 || unstaged > 0 || untracked > 0 )); then
    color="git_dirty"
  fi

  # ----- Get the branch display name

  if [[ "$oid" = "(initial)" ]]; then
    oid="initial"
  else
    # shorten SHA1 to 6 characters
    oid="${oid:0:6}"
  fi
  if [[ "$branch" = "(detached)" ]]; then
    branch="detached($oid)"
  fi

  # ----- Status details

  local details=""
  if (( PROMPT_ENABLE_GIT_FULLSTATUS == 1 )); then
    local upstream_status=""
    if (( ahead > 0 )); then
      upstream_status+="↑${ahead}"
    fi
    if (( behind > 0 )); then
      upstream_status+="↓${behind}"
    fi
    if [[ -n "$upstream_status" ]]; then
      details+=" ${upstream_status}"
    fi

    local counts=""
    if ((staged > 0)); then
      counts+="s${staged}"
    fi
    if ((unstaged > 0)); then
      counts+="u${unstaged}"
    fi
    if ((untracked > 0)); then
      counts+="?${untracked}"
    fi
    if ((unmerged > 0)); then
      counts+="!${unmerged}"
    fi
    if [[ -n "$counts" ]]; then
      details+=" $counts"
    fi
  fi

  local branch_icon="⎇"
  if (( PROMPT_USE_NERDFONT )); then
    branch_icon=""
  fi

  PROMPT_REPLY[color]="${color}"
  printf -v PROMPT_REPLY[content] '%s %s%s' "${branch_icon}" "${branch}" "${details}"
}

