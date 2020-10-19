
_prompt.git.is_repo() {
  if [[ -n "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]]
  then
    return 0
  fi
  return 1
}

_prompt.git.is_dirty() {
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
_prompt.git.branch() {
  git symbolic-ref -q --short HEAD 2> /dev/null || return 1
}
_prompt.git.tag() {
  git describe --tags --exact-match 2> /dev/null
}
_prompt.git.commit_desc() {
  git describe --contains --all 2> /dev/null
}
_prompt.git.short_sha() {
  git rev-parse --short HEAD
}
_prompt.git.ref() {
  _prompt.git.branch || _prompt.git.tag || _prompt.git.commit_desc || _prompt.git.short_sha
}
_prompt.git.status() {
  git status --porcelain 2>/dev/null
}
