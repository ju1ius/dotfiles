#!/bin/bash

exec col -bx | vim \
  -c "runtime! macros/less.vim" \
  -c "set nomod" \
  -
