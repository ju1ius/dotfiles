-- https://github.com/folke/lazy.nvim
-- `:h lazy.nvim.txt`

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    {import = 'my.plugins'},
  },
  defaults = {
    cond = function(plugin, opts)
      if vim.g.vscode then
        return plugin.vscode == true
      end
      if vim.g.started_by_firenvim then
        return plugin.firenvim == true
      end
      return true
    end,
  },
  checker = {
    enabled = not vim.g.vscode,
    frequency = 3600 * 4,
  },
  change_detection = {
    enabled = not vim.g.vscode,
  },
})

require('my.utils.keys').register_lazy_keys()
