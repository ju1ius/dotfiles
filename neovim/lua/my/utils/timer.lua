local M = {}

--@param time number
--@param callback fn()
--@return uv_timer_t
function M.delay(time, callback)
  return vim.defer_fn(callback, time)
end

return M
