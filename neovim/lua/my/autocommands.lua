do
  local group = vim.api.nvim_create_augroup('ju1ius/whitespace_settings', {})
  -- per filetype whitespace settings
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = { 'php', 'python', 'rust' },
    command = 'setlocal shiftwidth=4 softtabstop=4',
  })
  vim.api.nvim_create_autocmd('FileType', {
    group = group,
    pattern = 'make',
    command = 'setlocal noexpandtab',
  })
end

do
  local group = vim.api.nvim_create_augroup('ju1ius/terminal', {})
  -- new terminals shall start in terminal mode
  vim.api.nvim_create_autocmd('TermOpen', {
    group = group,
    pattern = { '*' },
    command = 'startinsert',
  })
end
