local opts = {
  on_new_config = function(config)
    config.settings.json.schemas = config.settings.json.schemas or {}
    vim.list_extend(config.settings.json.schemas, require('schemastore').json.schemas())
  end,
  settings = {
    json = {
      format = { enable = true },
      validate = { enable = true },
    },
  },
  setup = {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line('$'), 0 })
        end,
      },
    },
  },
}

return opts
