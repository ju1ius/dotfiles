
PROMPT_USER=""

if (( EUID == 0 ))
then
  # I'm root
  PROMPT_USER="${colors[user_root]}\u"
elif [[ "$USER" != "$LOGNAME" ]]
then
  PROMPT_USER="${colors[user_nologin]}\u"
fi
