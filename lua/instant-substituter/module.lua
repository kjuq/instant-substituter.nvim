local M = {}

_G._instant_substituter_callbacks = {}

---@param key string Key to execute replacement.
---@param lhs string Left-hand side of the string for replacement.
---@param rhs string Right-hand side of the string for replacement.
---@param debug boolean Whether to print debug messages.
M.bind = function(key, lhs, rhs, opts, debug)
	-- must remove "<", ">", and "-" to use a callback function as rhs of vim.go.operatorfunc
	local normalized_key = string.gsub(string.gsub(string.gsub(key, "%<", "_LEFTABRC_"), "%>", "_RIGHTABRC_"), "%-", "_")

	local swap = opts and opts.swap or false

	if debug then
		print("Key:", key, "| LHS:", lhs, "| RHS:", rhs, "| Normalized key:", normalized_key)
		print("Swap:", swap)
	end

	local visual_mode_main

	if swap then
		local tmp = "_temp_aTnuFgkVg0arhsIou4Aghufz_"
		_G._instant_substituter_callbacks[normalized_key] = function()
			vim.cmd("s/" .. lhs .. "/" .. tmp .. "/ge")
			vim.cmd("s/" .. rhs .. "/" .. lhs .. "/ge")
			vim.cmd("s/" .. tmp .. "/" .. rhs .. "/ge")
			vim.cmd.nohlsearch()
		end
		visual_mode_main = function()
			local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
			vim.api.nvim_feedkeys(esc, "x", false)
			vim.cmd("'<,'>s/" .. lhs .. "/" .. tmp .. "/ge")
			vim.cmd("'<,'>s/" .. rhs .. "/" .. lhs .. "/ge")
			vim.cmd("'<,'>s/" .. tmp .. "/" .. rhs .. "/ge")
			vim.cmd.nohlsearch()
		end
	else
		_G._instant_substituter_callbacks[normalized_key] = function()
			vim.cmd("s/" .. lhs .. "/" .. rhs .. "/ge")
			vim.cmd.nohlsearch()
		end
		visual_mode_main = function()
			local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
			vim.api.nvim_feedkeys(esc, "x", false)
			vim.cmd("'<,'>s/" .. lhs .. "/" .. rhs .. "/ge")
			vim.cmd.nohlsearch()
		end
	end

	_G._instant_substituter_main = function()
		vim.go.operatorfunc = "v:lua._instant_substituter_callbacks." .. normalized_key

		if debug then
			print("Operator Func: " .. vim.go.operatorfunc)
		end

		return "g@l"
	end

	local desc = "Instant-substituter: Substitute " .. lhs .. " with " .. rhs
	vim.keymap.set("n", key, _instant_substituter_main, { expr = true, desc = desc })
	vim.keymap.set("v", key, visual_mode_main, { desc = desc })
end

return M
