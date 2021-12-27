-- https://github.com/wbthomason/packer.nvim

-- Automatically install packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if not vim.loop.fs_stat(install_path) then
  PACKER_BOOTSTRAP = vim.fn.system({
    'git', 'clone', '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local filepath = debug.getinfo(1, 'S').source:sub(2)
local dirname = filepath:match('^(.*)/[^/]+$')
local reloadCmd = string.format(
  [[
    augroup packer_user_config
      autocmd!
      autocmd BufWritePost %s/init.lua lua require('my.utils').reload_vimrc()
    augroup end
  ]],
  dirname
)
vim.cmd(reloadCmd)

return function(setup)
  -- Use a protected call so we don't error out on first use
  local status_ok, packer = pcall(require, "packer")
  if not status_ok then
    return
  end

  -- Have packer use a popup window
  packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({border = 'rounded'})
      end,
    },
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath('config') .. '/lua/packer_compiled.lua'
  })

  -- Install your plugins here
  return packer.startup(function(use)
    setup(use)
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
      require('packer').sync()
    end
  end)

end

