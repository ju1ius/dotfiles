# shellcheck shell=bash

_prompt.text() {
  PROMPT_REPLY['content']="$1"
  PROMPT_REPLY['color']="${2:-default}"
}

_prompt.blank() {
  _prompt.text "$(echo -ne "\u200B")" "${1:-default}"
}

