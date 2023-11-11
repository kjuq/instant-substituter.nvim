---@class CustomModule
local M = {}

_G._instant_substituter_callbacks = {}

---@param key string Key to execute replacement.
---@param lhs string Left-hand side of the string for replacement.
---@param rhs string Right-hand side of the string for replacement.
---@param debug boolean Whether to print debug messages.
M.bind = function(key, lhs, rhs, debug)
	-- must remove "<", ">", and "-" to use a callback function as rhs of vim.go.operatorfunc
	local normalized_key = string.gsub(string.gsub(string.gsub(key, "%<", "_LEFTABRC_"), "%>", "_RIGHTABRC_"), "%-", "_")

	if debug then
		print("Key:", key, "| LHS: " .. lhs .. " | RHS: " .. rhs .. " | Normalized key: " .. normalized_key)
	end

	_G._instant_substituter_callbacks[normalized_key] = function()
		local cmd = "s/" .. lhs .. "/" .. rhs .. "/ge"
		vim.cmd(cmd)
		vim.cmd.nohlsearch()
	end

	_G.main_func = function()
		vim.go.operatorfunc = "v:lua._instant_substituter_callbacks." .. normalized_key

		if debug then
			print("Operator Func: " .. vim.go.operatorfunc)
		end

		return "g@l"
	end

	local desc = "Instant-substituter: Substitute " .. lhs .. " with " .. rhs
	vim.keymap.set("n", key, main_func, { expr = true, desc = desc })
	vim.keymap.set("v", key, function()
		local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
		vim.api.nvim_feedkeys(esc, "x", false)
		local cmd = "'<,'>s/" .. lhs .. "/" .. rhs .. "/ge"
		vim.cmd(cmd)
		vim.cmd.nohlsearch()
	end, { desc = desc })
end

return M
