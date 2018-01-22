#!/usr/bin/gawk -f

# Parses the output of git status --porcelain=2 --branch
# https://git-scm.com/docs/git-status

BEGIN {
  branch_oid = ""
  branch_head = ""
  branch_upstream = "?"
  branch_ahead = "0"
  branch_behind = "0"

  staged = 0
  unstaged = 0
  untracked = 0
  unmerged = 0
}
#----- Branch meta
/^# / {
  switch ($2) {
    case "branch.oid":
      branch_oid = $3
      break
    case "branch.head":
      branch_head = $3
      break
    case "branch.upstream":
      branch_upstream = $3
      break
    case "branch.ab":
      sub(/^\+/, "", $3)
      branch_ahead = $3
      sub(/^-/, "", $4)
      branch_behind = $4
      break
    default:
      break
  }
}
#----- Status
# untracked items
/^\? / {
  untracked++
}
# /^1 / ordinary changed entries
# /^2 / renamed/copied entries
/^[12] / {
  # modified ([^.]) in the index
  if ($2 ~ /^[^.].$/) {
    staged++
  }
  # modified ([^.]) in the work-tree
  if ($2 ~ /^.[^.]$/) {
    unstaged++
  }
}
# Unmerged entries
/^u / {
  unmerged++
}

END {
  print branch_oid, branch_head, branch_upstream, branch_ahead, branch_behind, staged, unstaged, untracked, unmerged
}
