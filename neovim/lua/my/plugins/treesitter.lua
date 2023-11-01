return {
  {
    -- https://github.com/nvim-treesitter/nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    vscode = true,
    firenvim = true,
    dependencies = {
      {'nvim-treesitter/nvim-treesitter-textobjects'},
      {
        -- https://github.com/JoosepAlviste/nvim-ts-context-commentstring,
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
        opts = { enable_autocmd = false },
      },
      {
        -- https://github.com/nvim-treesitter/nvim-treesitter-context
        'nvim-treesitter/nvim-treesitter-context',
        opts = { mode = "cursor", max_lines = 3 },
      },
    },
    build = ':TSUpdate',
    event = {'VeryLazy'},
    config = function(plugin, opts)
      local configs = require('nvim-treesitter.configs')
      local K = require("my.utils.keys")

      K.map({'n'}, "<leader>v", nil, {
        topic = "select",
        desc = [[Initiate incremental selection, then use +/- to increment/decrement or s to select scope.]]
      })

      configs.setup({
        -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        ensure_installed = {
          'bash', 'c', 'cmake', 'comment', 'cpp',
          'dockerfile', 'glsl', 'go', 'graphql',
          'html', 'http', 'java',
          'javascript', 'jsdoc', 'json', 'json5', 'jsonc',
          'lua', 'make', 'ninja', 'perl', 'php', 'python',
          'regex', 'rst', 'ruby', 'rust',
          'scss', 'supercollider', 'svelte', 'toml', 'tsx', 'typescript',
          'vim', 'vue', 'yaml', 'zig',
        },
        -- install languages synchronously (only applied to `ensure_installed`)
        sync_install = false,
        -- List of parsers to ignore installing
        ignore_install = {''},
        highlight = {
          -- false will disable the whole extension
          enable = not vim.g.vscode,
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
            init_selection = "<leader>v",
            node_incremental = "+",
            scope_incremental = "s",
            node_decremental = "-",
          },
        },
        autopairs = {
          enable = true,
        },
        autotag = {
          enable = true,
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

    end,
  }
}
