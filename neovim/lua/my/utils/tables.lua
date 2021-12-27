local M = {}

function M.pick(keys, t)
  local result = {}
  for _, key in ipairs(keys) do
    result[key] = t[key]
  end
  return result
end

return M
