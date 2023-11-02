local Methods = vim.lsp.protocol.Methods

--- Diagnostic severities.
local Signs = {
  ERROR = { name = 'DiagnosticSignError', text = '' },
  WARN = { name = 'DiagnosticSignWarn', text = '' },
  HINT = { name = 'DiagnosticSignHint', text = '' },
  INFO = { name = 'DiagnosticSignInfo', text = '' },
}

for _, sign in pairs(Signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

vim.diagnostic.config({
  -- show signs
  signs = {
    active = Signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  virtual_text = {
    --
    prefix = '',
    format = function(diag)
      local icon = Signs[vim.diagnostic.severity[diag.severity]].text
      local message = vim.split(diag.message, '\n')[1]
      return string.format('%s %s ', icon, message)
    end,
  },
  float = {
    focusable = false,
    style = 'minimal',
    border = 'solid',
    source = 'if_many',
    header = '',
    -- Show severity icons as prefixes.
    prefix = function(diag)
      local level = vim.diagnostic.severity[diag.severity]
      local prefix = string.format(' %s ', Signs[level].text)
      return prefix, 'diagnostic' .. level:gsub('^%l', string.upper)
    end,
  },
})

-- vim.lsp.handlers[Methods.textDocument_hover] = vim.lsp.with(vim.lsp.handlers.hover, {
--   border = 'solid',
-- })
--
-- vim.lsp.handlers[Methods.textDocument_signatureHelp] = vim.lsp.with(vim.lsp.handlers.signature_help, {
--   border = 'solid',
-- })
