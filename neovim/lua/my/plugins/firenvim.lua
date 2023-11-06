return {
  {
    'glacambre/firenvim',
    firenvim = true,
    build = function()
      vim.fn['firenvim#install'](0)
    end,
    init = function(plugin)
      vim.g.firenvim_config = {
        globalSettings = {
          alt = 'all',
        },
        localSettings = {
          ['.*'] = {
            takeover = 'never',
          },
        },
      }
    end,
  },
}
