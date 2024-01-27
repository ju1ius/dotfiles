-- https://github.com/mrcjkb/rustaceanvim
return {
  'mrcjkb/rustaceanvim',
  version = '^4',
  ft = { 'rust' },
  config = function(_, opts)
    vim.g.rustaceanvim = vim.tbl_deep_extend('force', {}, opts or {})
  end,
}