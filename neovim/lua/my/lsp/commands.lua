local Methods = vim.lsp.protocol.Methods

local M = {}

---LspAttach handler for commands registration
---@param client lsp.Client
---@param bufnr integer
function M.attach(client, bufnr)
  vim.api.nvim_buf_create_user_command(bufnr, 'LspDebug', function()
    require('my.utils.lsp').dump_clients({ buffer = bufnr })
  end, { desc = '[lsp] Dump LSP client configuration' })

  if client.supports_method(Methods.textDocument_formatting, { bufnr = bufnr }) then
    vim.api.nvim_buf_create_user_command(bufnr, 'LspFormat', vim.lsp.buf.format, { desc = '[lsp] Format document' })
  end

  if client.supports_method(Methods.textDocument_documentHighlight, { bufnr = bufnr }) then
    local group = vim.api.nvim_create_augroup('ju1ius/lsp/cursor_highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'InsertLeave', 'BufEnter' }, {
      group = group,
      buffer = bufnr,
      desc = 'Highlight references under the cursor',
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'InsertEnter', 'BufLeave' }, {
      group = group,
      buffer = bufnr,
      desc = 'Clear highlight references',
      callback = vim.lsp.buf.clear_references,
    })
  end

  if client.supports_method(Methods.textDocument_inlayHint, { bufnr = bufnr }) then
    local group = vim.api.nvim_create_augroup('ju1ius/lsp/toggle_inlay_hints', { clear = false })
    -- Initial inlay hint display.
    -- Without the delay inlay hints aren't displayed at the very start.
    vim.defer_fn(function()
      local mode = vim.api.nvim_get_mode().mode
      vim.lsp.inlay_hint.enable(bufnr, mode == 'n' or mode == 'v')
    end, 500)

    vim.api.nvim_create_autocmd('InsertEnter', {
      group = group,
      buffer = bufnr,
      desc = 'Enable inlay hints',
      callback = function()
        vim.lsp.inlay_hint.enable(bufnr, false)
      end,
    })
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = group,
      buffer = bufnr,
      desc = 'Disable inlay hints',
      callback = function()
        vim.lsp.inlay_hint.enable(bufnr, true)
      end,
    })
  end
end

return M
