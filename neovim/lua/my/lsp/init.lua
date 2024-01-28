-- TODO: replace manual config by https://github.com/VonHeikemen/lsp-zero.nvim
-- TODO: lsp status: j-hui/fidget.nvim || arkav/lualine-lsp-progress

local Methods = vim.lsp.protocol.Methods

vim.lsp.set_log_level('off')
-- vim.lsp.set_log_level('debug')

require('my.lsp.styles')

-- these have to come before lspconfig
require('neoconf').setup({})
require('neodev').setup({})

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local cmp_lsp = require('cmp_nvim_lsp')

util.default_config = vim.tbl_deep_extend('force', util.default_config, {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers.
    cmp_lsp.default_capabilities(),
    {
      workspace = {
        -- PERF: didChangeWatchedFiles is too slow.
        -- TODO: Remove this when https://github.com/neovim/neovim/issues/23291#issuecomment-1686709265 is fixed.
        didChangeWatchedFiles = { dynamicRegistration = false },
      },
    }
  ),
})

require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = {
    'lua_ls',
    'bashls',
  },
})
mason_lspconfig.setup_handlers({
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name)
    -- log.info('Handling server: ' .. server_name)
    local server = lspconfig[server_name]
    local ok, settings = pcall(require, 'my.lsp.servers.' .. server_name)
    if ok then
      -- log.info('Found settings for ' .. server_name)
      server.setup(settings)
    else
      -- log.info('No settings found for ' .. server_name)
      server.setup({})
    end
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ['rust_analyzer'] = function() end,
})

---Main LspAttach handler
---@param client lsp.Client
---@param bufnr integer
local function on_attach(client, bufnr)
  require('my.lsp.keymaps').attach(client, bufnr)
  require('my.lsp.commands').attach(client, bufnr)
  -- if client.server_capabilities.completionProvider then
  --   vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
  --   vim.api.nvim_set_option_value('omnifunc', 'v:lua.vim.lsp.omnifunc', { buf = bufnr })
  -- end
  -- if client.server_capabilities.definitionProvider then
  --   vim.bo[bufnr].tagfunc = 'v:lua.vim.lsp.tagfunc'
  --   vim.api.nvim_set_option_value('tagfunc', 'v:lua.vim.lsp.tagfunc', { buf = bufnr })
  -- end
end

-- Update mappings when registering dynamic capabilities.
local register_capability = vim.lsp.handlers[Methods.client_registerCapability]
vim.lsp.handlers[Methods.client_registerCapability] = function(err, res, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not client then
    return
  end
  on_attach(client, vim.api.nvim_get_current_buf())
  return register_capability(err, res, ctx)
end

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'Configure LSP client',
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if not client then
      return
    end
    on_attach(client, args.buf)
  end,
})
