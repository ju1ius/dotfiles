local M = {}

--@param time number
--@param callback fn()
--@return uv_timer_t
function M.delay(time, callback)
  local timer = vim.uv.new_timer()
  timer:start(time or 0, 0, vim.schedule_wrap(function()
    timer:stop()
    timer:close()
    callback()
  end))
  return timer
end

return M
