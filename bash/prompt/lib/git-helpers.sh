
__git_is_repo() {
  if [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]
  then
    return 0
  fi
  return 1
}

__git_is_dirty() {
  if [[ $(git diff --shortstat 2>/dev/null | tail -n1) ]];
  then
    return 0
  fi
  return 1
}

# When on a branch, this is often the same as _git-commit-description,
# but this can be different when two branches are pointing to the
# same commit. _git_branch is used to explicitly choose the checked-out
# branch.
__git_branch() {
  git symbolic-ref -q --short HEAD 2> /dev/null || return 1
}
__git_tag() {
  git describe --tags --exact-match 2> /dev/null
}
__git_commit_desc() {
  git describe --contains --all 2> /dev/null
}
__git_short_sha() {
  git rev-parse --short HEAD
}
__git_ref() {
  __git_branch || __git_tag || __git_commit_desc || __git_short_sha
}
__git_status() {
  git status --porcelain 2>/dev/null
}

__git_full_status() {
  local parser="$(dirname "${BASH_SOURCE[0]}")/git-parse-status.awk"
  git status --porcelain=2 --branch 2>/dev/null | "$parser"
}
