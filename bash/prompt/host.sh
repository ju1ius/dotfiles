
get_connection_type() {
  if [[ -n "${SSH_CLIENT-}${SSH2_CLIENT-}${SSH_TTY-}" ]]
  then
    echo 'ssh'
  else
    local whoami="$(LANG=C who am i)"
    local sess_parent="$(ps -o comm= -p $PPID 2> /dev/null)"
    if [[ "$whoami" != *'('* || "$whoami" = *'(:'* || "$whoami" = *'(tmux'* ]]
    then
      echo 'local'
    elif [[ "$sess_parent" = "su" || "$sess_parent" = "sudo" ]]
    then
      # Remote su/sudo
      echo 'su'
    else
      echo 'telnet'
    fi
  fi
}

get_host_prompt() {
  local connection_type=$(get_connection_type)
  local prompt_host=""
  # Put the hostname if not locally connected
  # color it in cyan within SSH, and a warning red if within telnet
  # else display the host without color
  # The connection is not expected to change from inside the shell,
  # so we build this just once
  [[ -r /etc/debian_chroot ]] && prompt_host="($(< /etc/debian_chroot))"
  if [[ "$connection_type" != 'local' ]]
  then
    prompt_host+="@\h"
    # If we are connected with a X11 support
    [[ -n "$DISPLAY" ]] && prompt_host+="$DISPLAY"
  fi

  case "$connection_type" in
    ssh)
      prompt_host="${colors[host_ssh]}${prompt_host}${nocolor}"
    ;;
    su)
      prompt_host="${colors[host_su]}${prompt_host}${nocolor}"
    ;;
    telnet)
      prompt_host="${colors[host_telnet]}${prompt_host}${nocolor}"
    ;;
    *)
      if [[ -n "$prompt_host" ]]; then
        prompt_host="${colors[host_default]}${prompt_host}${nocolor}"
      fi
    ;;
  esac
  if [[ -n "$prompt_host" ]]
  then
    prompt_host+=" "
  fi
  echo -ne "$prompt_host"
}

PROMPT_HOST=$(get_host_prompt)

unset -f get_connection_type
unset -f get_host_prompt
