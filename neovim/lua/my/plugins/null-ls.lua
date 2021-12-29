-- https://github.com/jose-elias-alvarez/null-ls.nvim

local null_ls = require('null-ls')

null_ls.setup({
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#available-sources
  sources = {
    -- null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.phpcsfixer,
    null_ls.builtins.diagnostics.shellcheck,
    null_ls.builtins.code_actions.shellcheck,
  }
})

