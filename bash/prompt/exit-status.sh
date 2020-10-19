_prompt.exit_status() {
  local -i code="$1"
  if (( code != 0 )); then
    PROMPT_REPLY[content]="${code}"
    PROMPT_REPLY[color]="error"
  else
    PROMPT_REPLY[content]=''
  fi
}
