local utils = require('my.utils')
require('my.options')
require('my.keymaps')
require('my.plugins')

utils.register_mappings()
utils.source('/autocommands.vim')

