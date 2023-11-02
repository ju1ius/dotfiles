-- Stuff to check:
-- https://github.com/ziontee113/syntax-tree-surfer

return {
  {
    -- https://github.com/echasnovski/mini.pairs
    -- TODO: check https://github.com/windwp/nvim-autopairs
    'echasnovski/mini.pairs',
    firenvim = true,
    event = 'VeryLazy',
    opts = {
      modes = {insert = true, command = false, terminal = true},
    },
  },
  {
    -- https://github.com/windwp/nvim-ts-autotag
    -- Automatically add closing tags for HTML and JSX
    'windwp/nvim-ts-autotag',
    firenvim = true,
  },
  {
    -- https://github.com/numToStr/Comment.nvim
    -- TODO: check https://github.com/echasnovski/mini.comment
    'numToStr/Comment.nvim',
    config = function(plugin, opts)
      require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      })
    end,
  },
  {
    -- https://github.com/machakann/vim-sandwich
    -- TODO: check https://github.com/echasnovski/mini.surround
    'machakann/vim-sandwich',
    vscode = true,
  },
  {
    -- https://github.com/lukas-reineke/indent-blankline.nvim
    'lukas-reineke/indent-blankline.nvim',
    config = function(plugin, opts)
      -- TODO: add keymap for :IndentBlanklineToggle
      require('ibl').setup({
        indent = {
          char = '▏',
        },
        scope = {
          enabled = true,
          char = '▏',
          -- show_start = false,
          highlight = 'Whitespace',
        },
        exclude = {
          buftypes = {'terminal', 'no_file'},
          filetypes = {
            "help",
            'startify',
            'dashboard',
            'packer',
            'neogitstatus',
            'NvimTree',
            'Trouble',
          },
        },
      })
    end,
  },
}
