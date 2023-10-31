return {
  -- Search & replace
  {
    -- https://github.com/nvim-pack/nvim-spectre
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    keys = {
      { '<leader>sr', function() require('spectre').open() end, desc = 'Replace in files (Spectre)' },
    },
  }
}
