# vim: ft=sh
# shellcheck shell=bash

# https://github.com/junegunn/fzf
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# https://github.com/cykerway/complete-alias
if [[ -f ~/.dotfiles/deps/complete-alias/complete_alias ]]; then
  export COMPAL_AUTO_UNMASK=1
  source ~/.dotfiles/deps/complete-alias/complete_alias
  complete -F _complete_alias "${!BASH_ALIASES[@]}"
fi
