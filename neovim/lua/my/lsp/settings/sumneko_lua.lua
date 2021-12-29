
return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.list_extend(
          {'lua/?.lua', 'lua/?/init.lua'},
          vim.split(package.path, ';')
        ),
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        -- library = {
        --   [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        --   [vim.fn.stdpath('config') .. '/lua'] = true,
        -- },
        -- see issues #679 and #783 (https://github.com/sumneko/lua-language-server/issues/679)
        checkThirdParty = false,
      },
      telemetry = {enable = false},
    },
  },
}
