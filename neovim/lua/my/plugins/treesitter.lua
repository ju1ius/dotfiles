-- https://github.com/nvim-treesitter/nvim-treesitter
local configs = require('nvim-treesitter.configs')

configs.setup({
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = 'maintained',
  -- install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,
  -- List of parsers to ignore installing
  ignore_install = {''},
  highlight = {
    -- false will disable the whole extension
    enable = true,
    -- list of language that will be disabled
    disable = {''},
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {'yaml'},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  autopairs = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
    enable_autocmd = false,
  },
  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
  },
})

-- set foldmethod to expression
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = [[nvim_treesitter#foldexpr()]]
-- start with folds open by default
vim.opt.foldlevel= 99

