local packer = require('my.plugins.packer')

local not_vscode = [[not vim.g.vscode]]

return packer(function(use)
  use 'lewis6991/impatient.nvim'
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
    config = [[require('my.plugins.treesitter')]],
    cond = not_vscode,
  }
  use {
    'JoosepAlviste/nvim-ts-context-commentstring',
    requires = {'nvim-treesitter/nvim-treesitter'},
    after = 'nvim-treesitter',
  }
  use {
    'navarasu/onedark.nvim',
    config = [[require('my.plugins.onedark')]],
    cond = not_vscode,
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
    },
    wants = {'nvim-web-devicons'},
    config = [[require('my.plugins.lualine')]],
    cond = not_vscode,
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
    },
    wants = {'nvim-web-devicons'},
    cmd = {'NvimTreeToggle', 'NvimTreeFindFileToggle'},
    setup = [[require('my.plugins.nvim-tree').setup()]],
    config = [[require('my.plugins.nvim-tree').configure()]],
    cond = not_vscode,
  }
  use {
    'akinsho/bufferline.nvim',
    tag = 'v3.*',
    requires = {
      {'kyazdani42/nvim-web-devicons'},
    },
    wants = {'nvim-web-devicons'},
    config = [[require('my.plugins.bufferline')]],
    cond = not_vscode,
  }
  -- LSP
  use {
    'neovim/nvim-lspconfig',
    config = [[require('my.plugins.lsp-setup')('nvim-lspconfig')]],
  }
  use {
    'williamboman/mason.nvim',
    cond = not_vscode,
    config = [[require('my.plugins.mason')]],
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    requires = {
      'neovim/nvim-lspconfig',
    },
    after = {'nvim-lspconfig', 'mason.nvim'},
    cond = not_vscode,
    config = [[require('my.plugins.lsp-setup')('mason-lspconfig')]],
  }
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = {
      'neovim/nvim-lspconfig',
    },
    after = {'nvim-lspconfig'},
    config = [[require('my.plugins.null-ls')]],
    cond = not_vscode,
  }
  use {
    'folke/trouble.nvim',
    requires = {
      {'kyazdani42/nvim-web-devicons', opt = true},
    },
    config = [[require('my.plugins.trouble')]],
    cond = not_vscode,
  }
  use {
    'j-hui/fidget.nvim',
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
      {'hrsh7th/cmp-nvim-lsp',
        after = {'nvim-cmp', 'mason-lspconfig.nvim'},
        config = [[require('my.plugins.lsp-setup')('cmp-nvim-lsp')]],
      },
    },
    config = [[require('my.plugins.cmp')]],
    cond = not_vscode,
    wants = 'LuaSnip',
  }
  -- Debuggers
  -- use {
  --   'mfussenegger/nvim-dap',
  --   cond = not_vscode,
  -- }
  -- use {
  --   'puremourning/vimspector',
  --   config = [[require('my.plugins.vimspector')]],
  --   cond = not_vscode,
  -- }
  -- snippet engine
  use {
    'L3MON4D3/LuaSnip',
    requires = {
      'rafamadriz/friendly-snippets',
    },
    cond = not_vscode,
  }
  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    },
    cmd = 'Telescope',
    module = 'telescope',
    setup = [[require('my.plugins.telescope').setup()]],
    config = [[require('my.plugins.telescope').configure()]],
    cond = not_vscode,
  }
  -- misc
  use {
    'machakann/vim-sandwich',
  }
  use {
    'mbbill/undotree',
    setup = [[require('my.plugins.undotree')]],
    cmd = 'UndotreeToggle',
    cond = not_vscode,
  }
  use {
    'numToStr/Comment.nvim',
    wants = {'nvim-ts-context-commentstring'},
    config = [[require('my.plugins.comment')]],
    cond = not_vscode,
  }
  use {
    'windwp/nvim-autopairs',
    config = [[require('my.plugins.autopairs')]],
    cond = not_vscode,
  }
  use {
    'windwp/nvim-ts-autotag',
    requires = {'nvim-treesitter/nvim-treesitter'},
    wants = {'nvim-treesitter'},
    config = [[require('my.plugins.autotag')]],
    cond = not_vscode,
  }
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = [[require('my.plugins.indent-blankline')]],
    cond = not_vscode,
  }
  -- git
  use {
    'lewis6991/gitsigns.nvim',
    requires = {'nvim-lua/plenary.nvim'},
    config = [[require('my.plugins.gitsigns')]],
    cond = not_vscode,
  }
  use {
    'tpope/vim-fugitive',
    cond = not_vscode,
  }
  use {
    'glacambre/firenvim',
    run = function() vim.fn['firenvim#install'](0) end,
    setup = [[require('my.plugins.firenvim')]],
    cond = [[vim.g.started_by_firenvim]],
  }
  -- Search & replace
  -- TODO: evaluare the following:
  -- https://github.com/dyng/ctrlsf.vim
  -- https://github.com/stefandtw/quickfix-reflector.vim

end)
