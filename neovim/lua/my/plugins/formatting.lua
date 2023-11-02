local FormatOnSave = {
  value = true,
}

---@param buf integer
---@return boolean
function FormatOnSave.enabled(buf)
  local value = vim.b[buf].format_on_save
  if value == nil then
    return FormatOnSave.value
  end
  return value
end

---@param buf integer
function FormatOnSave.toggle(buf)
  buf = buf or 0
  if FormatOnSave.enabled(buf) then
    vim.b[buf].format_on_save = false
  else
    vim.b[buf].format_on_save = true
  end
end

return {
  {
    -- https://github.com/stevearc/conform.nvim
    'stevearc/conform.nvim',
    dependencies = { 'mason.nvim' },
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leadef>cF',
        function()
          require('conform').format({ formatter = { 'injected' } })
        end,
        desc = 'Format injected languages',
      },
      {
        '<leader>taf',
        FormatOnSave.toggle,
        buffer = true,
        desc = 'Toggle format-on-save for the current buffer',
      },
    },
    config = function(_, opts)
      require('conform').setup({
        format_on_save = function(buf)
          if not FormatOnSave.enabled(buf) then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          sh = { 'shfmt' },
          php = { 'php_cs_fixer' },
        },
        formatters = {
          injected = { ignore_errors = true },
        },
      })

      vim.o.formatexpr = [[v:lua.require('conform').formatexpr()]]
    end,
  },
}
