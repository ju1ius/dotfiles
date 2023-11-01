-- https://github.com/puremourning/vimspector
--
-- https://puremourning.github.io/vimspector

-- vimspector is disabled
if true then return {} end

local map = require('my.utils.keys').map

local M = {}

-- function M.on_jump_to_frame()
--
-- end
--
-- function M.on_debug_end()
--
-- end
--
-- vim.cmd([[
--   augroup vimspector_mappings
--     autocmd!
--     autocmd User VimspectorJumpedToFrame lua require('my.plugins.vimspector').on_jump_to_frame()
--     autocmd User VimspectorDebugEnded ++nested lua require('my.plugins.vimspector').on_debug_end()
--   augroup END
-- ]])

map('n', '<leader>ds', '<Plug>VimspectorContinue', {
  topic = 'debug',
  desc = 'Start / continue debugging.',
})
map('n', '<leader>dS', '<Plug>VimspectorStop', {
  topic = 'debug',
  desc = 'Stop debugging.',
})
map('n', '<leader>dq', ':VimspectorReset', {
  topic = 'debug',
  desc = 'Quit debugger.',
})
map('n', '<leader>dr', '<Plug>VimpectorRestart', {
  topic = 'debug',
  desc = 'Restart debugging with the same configuration.',
})
map('n', '<leader>dp', '<Plug>VimspectorPause', {
  topic = 'debug',
  desc = 'Pause debuggee.',
})
map('n', '<leader>db', '<Plug>VimspectorToggleBreakpoint', {
  topic = 'debug',
  desc = 'Toggle line breakpoint on the current line.',
})
map('n', '<leader>dbc', '<Plug>VimspectorToggleConditionalBreakpoint', {
  topic = 'debug',
  desc = 'Toggle conditional line breakpoint or logpoint on the current line.',
})
map('n', '<leader>dbf', '<Plug>VimspectorAddFunctionBreakpoint', {
  topic = 'debug',
  desc = 'Add a function breakpoint for the expression under cursor.',
})
map('n', '<leader>dc', '<Plug>VimspectorRunToCursor', {
  topic = 'debug',
  desc = 'Run to cursor.',
})
map('n', '<leader>dj', '<Plug>VimspectorStepOver', {
  topic = 'debug',
  desc = 'Step over.',
})
map('n', '<leader>dh', '<Plug>VimspectorStepInto', {
  topic = 'debug',
  desc = 'Step into.',
})
map('n', '<leader>dk', '<Plug>VimspectorStepOut', {
  topic = 'debug',
  desc = 'Step out of current function.',
})
map('n', '<leader>du', '<Plug>VimspectorUpFrame', {
  topic = 'debug',
  desc = 'Move up a frame in the current call.',
})
map('n', '<leader>dd', '<Plug>VimspectorDownFrame', {
  topic = 'debug',
  desc = 'Move down a frame in the current call.',
})
map('n', '<leader>de', '<Plug>VimspectorBalloonEval', {
  topic = 'debug',
  desc = 'Evaluate expression under cursor (or visual) in popup internal.',
})

return M

