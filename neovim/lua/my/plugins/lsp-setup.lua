-- This module is a hack to allow setup of several plugins at once,
-- while preserving packer lazy-loading behaviour

local tbl = require('my.utils.tables')
local log = require('my.utils.log')

local deps = {
  ['nvim-lspconfig'] = true,
  ['mason-lspconfig'] = true,
  ['cmp-nvim-lsp'] = true,
}

local num_deps = tbl.hcount(deps)

return function(plugin)
  if deps[plugin] then
    deps[plugin] = nil
    num_deps = num_deps - 1
    if num_deps == 0 then
      require('my.lsp')
    end
  else
    log.warn('not an LSP plugin: ' .. plugin, 'ju1ius')
  end
end
