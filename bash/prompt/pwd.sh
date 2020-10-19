_prompt.cwd.truncate_left() {
  local -i max_len="$1"
  local cwd="$2"
  local ellipsis="${3:-…}"
  # show at least complete current directory
  local d="${cwd##*/}"
  # cut out the leaf directory
  local p="${cwd:0:${#cwd} - ${#d}}"
  printf '%s%s%s' "${ellipsis}" "${p:${#p} - ($max_len - ${#d} - ${#ellipsis})}" "${d}"
}

_prompt.cwd.shorten_path() {
  local -i max_len="$1"
  local -i keep_dirs="$2"
  local p="$3"
  local ellipsis="${4:-…}"
  # path with slashes removed
  local tmp="${p//\//}"
  # nuber of slashes in path
  local -i delims=$(( ${#p} - ${#tmp} ))
  local ret=""

  for (( dir = 0; dir < keep_dirs; dir++ )); do
    (( dir == delims )) && break
    local left="${p#*/}"
    local name="${p:0:${#p} - ${#left}}"
    p="$left"
    ret+="${name%/}/"
  done

  if (( delims <= keep_dirs ))
  then
    # no dirs between ${keep_dirs} leading dirs and current dir
    ret+="${p##*/}"
  else
    local base="${p##*/}"
    p="${p:0:${#p} - ${#base}}"
    [[ $ret != '/' ]] && ret="${ret%/}"
    local -i len_left=$(( max_len - ${#ret} - ${#base} - ${#ellipsis} ))
    ret+="${ellipsis}${p:${#p} - $len_left}${base}"
  fi

  printf '%s' "${ret}"
}


_prompt.pwd() {
  PROMPT_REPLY[color]='cwd'
  if (( ! PROMPT_SHORTEN_PATH ))
  then
    PROMPT_REPLY[content]='\w'
    return 0
  fi

  local cwd="${PWD/#$HOME/'~'}"
  local prompt_cwd=""
  local -i max_len=$(( ${COLUMNS:-80} * PROMPT_PATH_MAXLEN / 100))

  if (( ${#cwd} <= max_len ))
  then
    prompt_cwd="$cwd"
  elif (( PROMPT_PATH_KEEP == 0 ))
  then
    prompt_cwd="$(_prompt.cwd.truncate_left $max_len $cwd)"
  else
    prompt_cwd="$(_prompt.cwd.shorten_path $max_len $PROMPT_PATH_KEEP $cwd)"
  fi

  PROMPT_REPLY[content]="$prompt_cwd"
}
