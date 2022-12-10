#!/bin/bash

__DIR__="$(dirname "$(realpath -e "${BASH_SOURCE[0]}")")"

rm "${__DIR__}/lua/packer_compiled.lua"

exec nvim --headless --noplugin \
  -c 'autocmd User PackerComplete quitall' \
  -c 'PackerSync'
