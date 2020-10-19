_prompt.login.user() {
  if [[ "${EUID}" = "0" || "${USER}" != "${LOGNAME}" ]]
  then
    echo '\u'
  fi
}

_prompt.login.connection_type() {
  if [[ -n "${SSH_CLIENT-}${SSH2_CLIENT-}${SSH_TTY-}" ]]
  then
    echo 'ssh'
  else
    local whoami="$(LANG=C who am i)"
    local sess_parent="$(ps -o comm= -p $PPID 2> /dev/null)"
    if [[ "${whoami}" != *'('* || "${whoami}" = *'(:'* || "${whoami}" = *'(tmux'* ]]
    then
      echo 'local'
    elif [[ "${sess_parent}" = "su" || "${sess_parent}" = "sudo" ]]
    then
      # Remote su/sudo
      echo 'su'
    else
      echo 'telnet'
    fi
  fi
}

_prompt.login() {
  local connection_type="$(_prompt.login.connection_type)"
  local login=""

  if [[ "${connection_type}" != 'local' ]]
  then
    login="${connection_type}:"
  fi

  login+="$(_prompt.login.user)"

  if [[ -r /etc/debian_chroot ]]; then
    login+="(chroot:$(< /etc/debian_chroot))"
  fi

  if [[ "${connection_type}" != 'local' ]]
  then
    login+="@\h"
    # If we are connected with a X11 support
    [[ -n "${DISPLAY}" ]] && login+="${DISPLAY}"
  fi

  printf '%s' "${login}"
}

