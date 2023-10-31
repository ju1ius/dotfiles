local log = require('my.utils.log')

require('neoconf').setup({})
require('neodev').setup({})

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local cmp_lsp = require('cmp_nvim_lsp')

local default_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = {
  textDocument = {
    completion = {
      completionItem = {
        snippetSupport = true,
      },
    },
    codeAction = {
      resolveSupport = {
        properties = vim.list_extend(default_capabilities.textDocument.codeAction.resolveSupport.properties, {
          'documentation',
          'detail',
          'additionalTextEdits',
        }),
      },
    },
  },
}

util.default_config = vim.tbl_deep_extend('force', util.default_config, {
  capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    cmp_lsp.default_capabilities(capabilities)
  ),
})

require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup({
  ensure_installed = {
    -- 'bashls',
    -- 'clangd',
    -- 'dockerls',
    -- 'html',
    -- 'jsonls',
    -- 'tsserver',
    -- 'rust_analyzer',
    -- 'sumneko_lua',
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
  -- ['rust_analyzer'] = function()
  --     require('rust-tools').setup({})
  -- end
})
