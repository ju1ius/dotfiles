
-- per filetype whitespace settings --

local ws_group = vim.api.nvim_create_augroup('whitespace_settings', {})
vim.api.nvim_create_autocmd('FileType', {
  group = ws_group,
  pattern = {'php', 'python'},
  command = 'setlocal shiftwidth=4 softtabstop=4',
})
vim.api.nvim_create_autocmd('FileType', {
  group = ws_group,
  pattern = 'make',
  command = 'setlocal noexpandtab',
})

