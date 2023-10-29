# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# ----- Standard $PATH setup
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.local/share/man" ]; then
  MANPATH="${MANPATH-$(manpath)}:${HOME}/.local/share/man"
fi

# neovim binaries
if [ -d "$HOME/.local/share/bob/nvim-bin" ]; then
  PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
fi

# Composer binaries
if [ -d "$HOME/.config/composer/vendor/bin" ]; then
  PATH="$HOME/.config/composer/vendor/bin:$PATH"
fi

# Python binaries
if [ -d "$HOME/.pyenv" ]; then
  PYENV_ROOT="$HOME/.pyenv"
  PATH="${PYENV_ROOT}/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
  fi
fi
if [ -d "$HOME/.poetry" ]; then
  PATH="$HOME/.poetry/bin:$PATH"
fi

if [ -e "$HOME/.local/bin/deno" ]; then
  DENO_INSTALL="$HOME/.local"
fi

# Rust / Rustup
if [ -f "${HOME}/.cargo/env" ]; then
  . "${HOME}/.cargo/env"
fi

# bun
if [ -d "$HOME/.bun" ]; then
  BUN_INSTALL="$HOME/.bun"
  PATH="$BUN_INSTALL/bin:$PATH"
fi

if [ -f "${HOME}/.env" ]; then
  . "${HOME}/.env"
fi
