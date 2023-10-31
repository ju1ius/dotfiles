local M = {}

---@alias Key string
---@alias Value any

--Returns a new table containing only the provided keys.
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

--Like [Self.pick] but modifies the table in-place
---@generic K: Key, V: Value
---@param keys K[]
---@param t table<K, `V`>
function M.keep(keys, t)
  local lookup = M.to_lookup(keys)
  for key, _ in pairs(t) do
    if lookup[key] == nil then
      t[key] = nil
    end
  end
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

function M.to_lookup(t)
  local result = {}
  for _, value in ipairs(t) do
    result[value] = true
  end
  return result
end

return M
