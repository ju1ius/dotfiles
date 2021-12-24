local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local runtime_lib = vim.api.nvim_get_runtime_file('', true)

return {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = runtime_lib,
--        library = {
--          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--          [vim.fn.stdpath('config') .. '/lua'] = true,
--        },
      },
      telemetry = {enable = false},
    },
  },
}
