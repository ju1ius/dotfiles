return {
  on_new_config = function(config)
    config.settings.yaml.schemas =
      vim.tbl_deep_extend('force', config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
  end,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      format = { enable = true },
      validate = true,
    },
  },
}
