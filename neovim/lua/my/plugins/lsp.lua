return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      {"folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = {"nvim-lspconfig"}},
      {"folke/neodev.nvim", opts = {}},
    },
    config = function()
      require('my.lsp')
    end
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    config = function(plugin, opts)
      local null_ls = require('null-ls')
      null_ls.setup({
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#available-sources
        sources = {
          -- null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.phpcsfixer,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.code_actions.shellcheck,
        },
      })
    end,
  },
  {
    'folke/trouble.nvim',
    dependencies = {
      {'kyazdani42/nvim-web-devicons'},
    },
    cmd = {'TroubleToggle'},
    init = function ()
      local map = require('my.utils.keys').map
      map('n', '<leader>td', ':TroubleToggle<CR>', {
        topic = 'lsp',
        desc = 'Toggle diagnostics window (trouble.nvim)',
      })
    end,
    config = function(plugin, opts)
      -- https://github.com/folke/trouble.nvim#%EF%B8%8F-configuration
      require('trouble').setup({})
    end,
  },
  {
    'j-hui/fidget.nvim',
  },
}
