local utils = require('user.utils')
require('user.options')
require('user.keymaps')
require('user.plugins')

utils.register_mappings()
utils.source('/autocommands.vim')

