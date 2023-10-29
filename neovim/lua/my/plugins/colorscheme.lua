return {
  {
    -- https://github.com/navarasu/onedark.nvim
    'navarasu/onedark.nvim',
    priority = 1000,
    firenvim = true,
    config = function(plugin, opts)
      require('onedark').setup({
        style = 'dark',
      })
      vim.cmd.colorscheme('onedark')
    end,
  },
}
