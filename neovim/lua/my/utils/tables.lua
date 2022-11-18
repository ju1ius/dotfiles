local M = {}

---@alias Key string
---@alias Value any

---@generic K: Key, V: Value
---@param keys K[]
---@param t table<K, `V`>
---@return table<V, K>
function M.pick(keys, t)
  local result = {}
  for _, key in ipairs(keys) do
    result[key] = t[key]
  end
  return result
end

local function count(t, iter)
  local n = 0
  for _, _ in iter(t) do n = n + 1 end
  return n
end

---@param t table
---@return number
function M.hcount(t)
  return count(t, pairs)
end

---@param t any[]
---@return number
function M.icount(t)
  return count(t, ipairs)
end

return M
