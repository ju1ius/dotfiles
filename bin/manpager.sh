#!/bin/sh

if command -v batcat; then
  exec col -bx | batcat -pl man
else
  exec col -bx | vim \
    -c "set ft=man nomod titlestring=${MAN_PN}" \
    -
fi

