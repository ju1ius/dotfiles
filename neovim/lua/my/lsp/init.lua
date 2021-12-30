local K = require('my.utils.keys')

local M = {
  capabilities = vim.lsp.protocol.make_client_capabilities(),
}

-- TODO: backfill this to template
local signs = {
  {name = 'DiagnosticSignError', text = ''},
  {name = 'DiagnosticSignWarn', text = ''},
  {name = 'DiagnosticSignHint', text = ''},
  {name = 'DiagnosticSignInfo', text = ''},
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ''})
end

vim.diagnostic.config({
  -- disable virtual text
  virtual_text = false,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  K.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Go to declaration',
  })
  K.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Go to definition',
  })
  K.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Show popup',
  })
  K.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Go to implementations',
  })
  K.map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Show signature',
  })
  K.map('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Rename symbol',
  })
  K.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Go to references',
  })
  K.map('n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Code action',
  })
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  K.map('n', ']d', '<cmd>lua vim.diagnostic.goto_next({border = "rounded"})<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Go to next diagnostic',
  })
  K.map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({border = "rounded"})<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Go to previous diagnostic',
  })
  K.map('n', 'gl', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border = "rounded"})<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Show line diagnostics',
  })
  K.map('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Show diagnostics loclist',
  })
  K.map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    summary = 'Format document',
  })
  vim.cmd([[
    command! Format execute 'lua vim.lsp.buf.formatting()'
  ]])
end

M.on_attach = function(client, bufnr)
  if client.name == 'tsserver' then
    client.resolved_capabilities.document_formatting = false
  end
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
end

return M

