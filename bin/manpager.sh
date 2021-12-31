#!/bin/bash

exec col -bx | vim \
  -c "set ft=man nomod titlestring=${MAN_PN}" \
  -

