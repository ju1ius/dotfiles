local K = require('my.utils.keys')

local function set_buf_keymaps(bufnr)
  K.map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to declaration',
  })
  K.map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to definition',
  })
  K.map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Show popup',
  })
  K.map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to implementations',
  })
  K.map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Show signature',
  })
  K.map('n', '<leader>lrn', '<cmd>lua vim.lsp.buf.rename()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Rename symbol',
  })
  K.map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to references',
  })
  K.map('n', '<leader>lca', '<cmd>lua vim.lsp.buf.code_action()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Code action',
  })
  K.map('n', ']d', '<cmd>lua vim.diagnostic.goto_next({border = "rounded"})<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to next diagnostic',
  })
  K.map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev({border = "rounded"})<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Go to previous diagnostic',
  })
  K.map('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Show line diagnostics',
  })
  K.map('n', '<leader>lq', '<cmd>lua vim.diagnostic.setloclist()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Show diagnostics loclist',
  })
  K.map('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', {
    buffer = bufnr,
    topic = 'lsp',
    desc = 'Format document',
  })
  vim.cmd([[
    command! Format execute 'lua vim.lsp.buf.formatting()'
  ]])
end

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.server_capabilities.completionProvider then
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
    end
    if client.server_capabilities.definitionProvider then
      vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
    end

    set_buf_keymaps(bufnr)
  end
})

