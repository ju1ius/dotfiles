local cmp_lsp = require('cmp_nvim_lsp')
local lsp = require('user.lsp')

lsp.capabilities = cmp_lsp.update_capabilities(lsp.capabilities)
