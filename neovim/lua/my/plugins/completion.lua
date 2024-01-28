return {
  {
    -- https://github.com/hrsh7th/nvim-cmp
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path', -- path completions
      'hrsh7th/cmp-cmdline', -- cmdline completions
      'saadparwaiz1/cmp_luasnip', -- snippet completions
      'hrsh7th/cmp-nvim-lsp',
    },
    event = { 'InsertEnter' },
    config = function(plugin, opts)
      -- https://github.com/hrsh7th/nvim-cmp
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip/loaders/from_vscode').lazy_load()
      local map = require('my.utils.keys').map

      map({ 'i', 'c' }, '<C-Space>', nil, {
        topic = 'cmp',
        desc = 'trigger autocompletion dropdown',
      })

      -- Fixes the caret jumping around when cancelling an unfinished snippet
      -- see: https://github.com/L3MON4D3/LuaSnip/issues/872
      vim.api.nvim_create_autocmd('ModeChanged', {
        desc = 'Cancel the snippet session when leaving insert mode',
        group = vim.api.nvim_create_augroup('ju1ius/snippets/unlink', { clear = true }),
        pattern = { 's:n', 'i:*' },
        callback = function(args)
          if
            luasnip.session
            and luasnip.session.current_nodes[args.buf]
            and not luasnip.session.jump_active
            and not luasnip.choice_active()
          then
            luasnip.unlink_current()
          end
        end,
      })

      --   פּ ﯟ   some other good icons
      local kind_icons = {
        Text = '',
        Method = 'm',
        Function = '',
        Constructor = '',
        Field = '',
        Variable = '',
        Class = '',
        Interface = '',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '',
        Keyword = '',
        Snippet = '',
        Color = '',
        File = '',
        Reference = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = '',
        Event = '',
        Operator = '',
        TypeParameter = '',
      }
      -- find more here: https://www.nerdfonts.com/cheat-sheet

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        mapping = {
          ['<C-k>'] = cmp.mapping.select_prev_item(),
          ['<C-j>'] = cmp.mapping.select_next_item(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-1),
          ['<C-d>'] = cmp.mapping.scroll_docs(1),
          ['<C-Space>'] = cmp.mapping.complete(),
          -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
          ['<C-y>'] = cmp.config.disable,
          ['<C-e>'] = cmp.mapping.abort(),
          -- Accept currently selected item. If none selected, `select` first item.
          -- Set `select` to `false` to only confirm explicitly selected items.
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            vim_item.menu = ({
              nvim_lsp = '[lsp]',
              luasnip = '[snip]',
              buffer = '[buf]',
              path = '[path]',
            })[entry.source.name]
            return vim_item
          end,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
      })
    end,
  },
}
