local packer = require('user.plugins.packer')

local not_vscode = [[not vim.g.vscode]]

return packer(function(use)
  -- Have packer manage itself
  use 'wbthomason/packer.nvim'
  -- Useful lua functions used ny lots of plugins
  use 'nvim-lua/plenary.nvim'
  -- An implementation of the Popup API from vim in Neovim
  -- use 'nvim-lua/popup.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      {'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter'},
    },
    run = ':TSUpdate',
    config = [[require('user.plugins.treesitter')]],
    cond = not_vscode,
  }
  use {
    'navarasu/onedark.nvim',
    config = [[require('user.plugins.onedark')]],
    cond = not_vscode,
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
    },
    wants = {'nvim-web-devicons'},
    config = [[require('user.plugins.lualine')]],
    cond = not_vscode,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
    },
    wants = {'nvim-web-devicons'},
    cmd = 'NvimTreeToggle',
    config = [[require('user.plugins.nvim-tree')]],
    cond = not_vscode,
  }
  use {
    'akinsho/bufferline.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
      {'moll/vim-bbye'},
    },
    wants = {'nvim-web-devicons', 'vim-bbye'},
    config = [[require('user.plugins.bufferline')]],
    cond = not_vscode,
  }
  -- LSP
  use {
    'williamboman/nvim-lsp-installer',
    requires = {
      'neovim/nvim-lspconfig',
    },
    wants = {'nvim-lspconfig'},
    config = [[require('user.plugins.lsp-installer')]],
    cond = not_vscode,
  }
  -- snippet engine
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      'rafamadriz/friendly-snippets',
    },
    cond = not_vscode,
  }
  -- The completion plugin
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'L3MON4D3/LuaSnip'},
      {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
      {'hrsh7th/cmp-path', after = 'nvim-cmp'}, -- path completions
      {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'}, -- cmdline completions
      {'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp'}, -- snippet completions
      {
        'hrsh7th/cmp-nvim-lsp',
        config = [[require('user.plugins.cmp-lsp')]],
        after = {'nvim-cmp', 'nvim-lspconfig'},
      },
    },
    config = [[require('user.plugins.cmp')]],
    cond = not_vscode,
    wants = 'LuaSnip',
  }
  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    },
    config = [[require('user.plugins.telescope')]],
    cond = not_vscode,
  }
  -- misc
  use {
    'numToStr/Comment.nvim',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = [[require('user.plugins.comment')]],
    cond = not_vscode,
  }
  use {
    'windwp/nvim-autopairs',
    config = [[require('user.plugins.autopairs')]],
    cond = not_vscode,
  }
  use {
    'windwp/nvim-ts-autotag',
    config = [[require('user.plugins.autotag')]],
    cond = not_vscode,
  }
  use {
    'machakann/vim-sandwich',
  }
  -- git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = [[require('user.plugins.gitsigns')]],
    cond = not_vscode,
  }

end)

