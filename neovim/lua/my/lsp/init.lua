vim.lsp.set_log_level('debug')

-- TODO: replace manual config by https://github.com/VonHeikemen/lsp-zero.nvim
-- TODO: lsp status: j-hui/fidget.nvim || arkav/lualine-lsp-progress

require('my.lsp.keymaps')
require('my.lsp.styles')
require('my.lsp.highlight')
require('my.lsp.setup')
