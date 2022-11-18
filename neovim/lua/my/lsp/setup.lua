local log = require('my.utils.log')

local lspconfig = require('lspconfig')
local util = require('lspconfig.util')
local mason = require('mason-lspconfig')
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

mason.setup({
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

mason.setup_handlers({
  function(server_name)
    log.info('Handling server: ' .. server_name)
    local server = lspconfig[server_name]
    local ok, settings = pcall(require, 'my.lsp.settings.' .. server_name)
    if ok then
      log.info('Found settings for ' .. server_name)
      server.setup(settings)
    else
      log.info('No settings found for ' .. server_name)
      server.setup({})
    end
  end,
})
