
PROMPT_USER=""

if (( EUID == 0 ))
then
  # I'm root
  PROMPT_USER="${colors[user_root]} \u${nocolor}"
elif [[ "$USER" != "$LOGNAME" ]]
then
  PROMPT_USER="${colors[user_nologin]} \u${nocolor}"
fi

if [[ -n "$PROMPT_USER" ]]
then
  PROMPT_USER=" $PROMPT_USER"
fi
