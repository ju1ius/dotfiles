
local function highlight_references()
  vim.lsp.buf.document_highlight()
end

local augroup = vim.api.nvim_create_augroup('lsp_document_highlight', {})

local function lsp_highlight_document(bufnr)
  vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
    buffer = bufnr,
    group = augroup,
    callback = highlight_references,
  })
  vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
    buffer = bufnr,
    group = augroup,
    callback = function()
      vim.lsp.buf.clear_references()
    end,
  })
end


vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    
    if client.supports_method('textDocument/documentHighlight') then
      lsp_highlight_document(bufnr)
    end
  end
})

