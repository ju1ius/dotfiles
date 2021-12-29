-- https://github.com/puremourning/vimspector
--
-- https://puremourning.github.io/vimspector

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
  summary = 'Start / continue debugging.',
})
map('n', '<leader>dS', '<Plug>VimspectorStop', {
  summary = 'Stop debugging.',
})
map('n', '<leader>dq', ':VimspectorReset', {
  summary = 'Quit debugger.',
})
map('n', '<leader>dr', '<Plug>VimpectorRestart', {
  summary = 'Restart debugging with the same configuration.',
})
map('n', '<leader>dp', '<Plug>VimspectorPause', {
  summary = 'Pause debuggee.',
})
map('n', '<leader>db', '<Plug>VimspectorToggleBreakpoint', {
  summary = 'Toggle line breakpoint on the current line.',
})
map('n', '<leader>dbc', '<Plug>VimspectorToggleConditionalBreakpoint', {
  summary = 'Toggle conditional line breakpoint or logpoint on the current line.',
})
map('n', '<leader>dbf', '<Plug>VimspectorAddFunctionBreakpoint', {
  summary = 'Add a function breakpoint for the expression under cursor.',
})
map('n', '<leader>dc', '<Plug>VimspectorRunToCursor', {
  summary = 'Run to cursor.',
})
map('n', '<leader>dj', '<Plug>VimspectorStepOver', {
  summary = 'Step over.',
})
map('n', '<leader>dh', '<Plug>VimspectorStepInto', {
  summary = 'Step into.',
})
map('n', '<leader>dk', '<Plug>VimspectorStepOut', {
  summary = 'Step out of current function.',
})
map('n', '<leader>du', '<Plug>VimspectorUpFrame', {
  summary = 'Move up a frame in the current call.',
})
map('n', '<leader>dd', '<Plug>VimspectorDownFrame', {
  summary = 'Move down a frame in the current call.',
})
map('n', '<leader>de', '<Plug>VimspectorBalloonEval', {
  summary = 'Evaluate expression under cursor (or visual) in popup internal.',
})

return M

