local M = {}

---@param lines string[]
---@return integer win, integer buf
local function show_in_split(lines)
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_text(buf, 0, 0, 0, 0, lines)
  local split = vim.api.nvim_win_call(win, function()
    vim.cmd('silent noswapfile vsplit')
    return vim.api.nvim_get_current_win()
  end)
  vim.api.nvim_win_set_buf(split, buf)
  vim.api.nvim_set_current_win(split)
  return split, buf
end

---@param buffer integer
function M.dump_clients(buffer)
  buffer = buffer or 0
  local clients = vim.lsp.get_clients(buffer)
  local lines = vim.split(vim.inspect(clients), '\n')
  local win, buf = show_in_split(lines)
  vim.api.nvim_set_option_value('filetype', 'lua', { buf = buf })
end

return M
