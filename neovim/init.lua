--For quick debugging in command mode
function _G.dbg(...)
  print(vim.inspect(...))
  return ...
end

require('my.options')
require('my.keymaps')
require('my.autocommands')
require('my.lazy-config')
