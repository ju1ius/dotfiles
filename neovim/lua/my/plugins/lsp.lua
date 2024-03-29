-- Stuff to check:
-- LspSaga: https://nvimdev.github.io/lspsaga
return {
  {
    -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = false, dependencies = { 'nvim-lspconfig' } },
      { 'folke/neodev.nvim', opts = {} },
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('my.lsp')
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    dependencies = { 'mason.nvim' },
    config = function(plugin, opts)
      local null_ls = require('null-ls')
      null_ls.setup({
        -- https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md#available-sources
        sources = {},
      })
    end,
  },
  {
    -- https://github.com/folke/trouble.nvim
    'folke/trouble.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons' },
    },
    cmd = { 'TroubleToggle' },
    init = function()
      local map = require('my.utils.keys').map
      map('n', '<leader>td', ':TroubleToggle<CR>', {
        topic = 'lsp',
        desc = 'Toggle diagnostics window (trouble.nvim)',
      })
    end,
    config = function(plugin, opts)
      require('trouble').setup({})
    end,
  },
  {
    -- https://github.com/j-hui/fidget.nvim
    'j-hui/fidget.nvim',
    tag = 'legacy',
    event = 'LspAttach',
    opts = {},
  },
}
