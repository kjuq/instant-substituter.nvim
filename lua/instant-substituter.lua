-- main module file
local module = require("instant-substituter.module")

---@class Config
---@field keys table
---@field debug boolean
local config = {
	keys = {},
	debug = false,
}

local M = {}

---@type Config
M.config = config

M.bind = function()
	local keys = M.config.keys
	local debug = M.config.debug
	for key, v in pairs(keys) do
		local lhs = v[1]
		local rhs = v[2]
		module.bind(key, lhs, rhs, debug)
	end
end

---@param args Config?
M.setup = function(args)
	M.config = vim.tbl_deep_extend("force", M.config, args or {})
	M.bind()
end

return M
