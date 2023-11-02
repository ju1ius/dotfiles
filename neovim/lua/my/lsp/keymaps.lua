local Methods = vim.lsp.protocol.Methods

local map = require('my.utils.keys').map

local M = {}

---LspAttach handler for keymaps registration
---@param client lsp.Client
---@param bufnr integer
function M.attach(client, bufnr)
  map('n', 'K', vim.lsp.buf.hover, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Show popup',
  })
  map('n', 'gD', vim.lsp.buf.declaration, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to declaration',
  })
  map('n', 'gd', vim.lsp.buf.definition, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to definition',
  })
  map('n', 'gi', vim.lsp.buf.implementation, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to implementations',
  })
  map('n', 'gr', vim.lsp.buf.references, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to references',
  })
  map('n', 'gl', vim.diagnostic.open_float, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Show line diagnostics',
  })
  map('n', ']d', vim.diagnostic.goto_next, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to next diagnostic',
  })
  map('n', '[d', vim.diagnostic.goto_prev, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to previous diagnostic',
  })
  map('n', '<leader>lq', vim.diagnostic.setloclist, {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Show diagnostics loclist',
  })

  if client.supports_method(Methods.textDocument_codeAction, { bufnr = bufnr }) then
    map('n', '<leader>lca', vim.lsp.buf.code_action, {
      buffer = bufnr,
      topic = 'lsp',
      desc = 'Code action',
    })
  end
  if client.supports_method(Methods.textDocument_rename, { bufnr = bufnr }) then
    map('n', '<leader>lrn', vim.lsp.buf.rename, {
      buffer = bufnr,
      topic = 'lsp',
      desc = 'Rename symbol',
    })
  end
  if client.supports_method(Methods.textDocument_signatureHelp, { bufnr = bufnr }) then
    map({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, {
      buffer = bufnr,
      topic = 'lsp',
      desc = 'Show signature',
    })
  end
  if client.supports_method(Methods.textDocument_formatting, { bufnr = bufnr }) then
    map('n', '<leader>lf', vim.lsp.buf.format, {
      buffer = bufnr,
      topic = 'lsp',
      desc = 'Format document',
    })
  end
end

return M
