require('my.options')
require('my.keymaps')
require('my.autocommands')
require('my.plugins')
if not vim.g.vscode then
  require('my.lsp')
end
