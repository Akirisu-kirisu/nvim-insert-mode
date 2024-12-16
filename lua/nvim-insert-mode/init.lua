local n = require("nui-components")
local M = {}

function M.setup(opts)
	opts = opts or {}
end

function M.insert_hop()
	local line_content = vim.api.nvim_get_current_line()
	-- Temporarily switch to normal mode and perform common actions
	vim.cmd("normal! <C-o>") -- Go to normal mode briefly
	vim.cmd("normal! h") -- Move cursor left (modify as needed)
	vim.cmd("normal! l") -- Move cursor right (modify as needed)
	vim.cmd("normal! v") -- Enter visual mode

	-- Check if the line is empty and choose the appropriate hop command
	if line_content == "" then
		vim.cmd("HopAnywhere") -- Hop to the desired position
	else
		vim.cmd("HopAnywhereCurrentLine") -- Hop to the desired position
	end
end

function M.insert_find_cut()
	-- Temporarily switch to normal mode and perform common actions

	local line_content = vim.api.nvim_get_current_line()

	vim.cmd("normal! <C-o>") -- Go to normal mode briefly
	vim.cmd("normal! ma") -- Mark the current position

	-- Choose the appropriate hop command based on whether the line is empty
	if line_content == "" then
		-- vim.cmd("HopAnywhere") -- Hop to the desired position
		require("sj").run({
			pattern_type = "lua_plain",
			forward_search = true,
			separator = "",
			relative_labels = true,
			update_search_register = true,
			seach_scope = "buffer",
			use_last_pattern = false,
			inclusive = true,
		})
	else
		-- vi.cmd("HopAnywhereCurrentLine") -- Hop to the esired position
		require("sj").run({
			auto_jump = true,
			separator = "",
			pattern_type = "lua_plain",
			forward_search = true,
			relative_labels = true,
			update_search_register = true,
			-- seach_scope = "buffer",
			search_scope = "current_line", --works with other scopes
			use_last_pattern = false,
			inclusive = true,
		})
	end

	-- Common actions after hopping
	vim.cmd("normal! v") -- Enter visual mode
	vim.cmd("normal! h") -- Move cursor left (modify as needed)
	vim.cmd("normal! l") -- Move cursor right (modify as needed)
	vim.cmd("normal! d") -- Delete the selected text
	vim.cmd("normal! `a") -- Go to the marked position
	vim.cmd("normal! h") -- Move cursor left (modify as needed)
end

function M.insert_find_replace()
    -- Create the NUI renderer and signal
    -- local renderer = n.create_renderer({
    --     width = 60,
    --     height = 8,
    -- })
    --
    -- local signal = n.create_signal({
    --     is_loading = false,
    --     text = "Find & Replace",
    -- })
    --
    -- -- Body of the NUI window
    -- local body = function()
    --     return n.rows(
    --         n.columns(
    --             { flex = 0 },
    --             n.text_input({
    --                 id = "find-input",
    --                 autofocus = true,
    --                 flex = 1,
    --                 max_lines = 1,
    --                 placeholder = "Find",
    --                 on_change = function(value)
    --                     signal.text = value
    --                     local replace_char = value
    --
    --                     --
    --                     if replace_char == "" then
    --                         return
    --                     end
    --
    --                     local line_content = vim.api.nvim_get_current_line()
    --                     local input_length = #replace_char
    --                 end,
    --             }),
    --             n.gap(1),
    --             n.text_input({
    --                 id = "replace-input",
    --                 flex = 1,
    --                 max_lines = 1,
    --                 placeholder = "Replace",
    --             }),
    --             n.gap(1),
    --             n.button({
    --                 label = "Replace",
    --                 padding = { top = 1 },
    --                 on_press = function()
    --                     signal.is_loading = true
    --
    --                     vim.defer_fn(function()
    --                         -- Get user input
    --                         local find_text = renderer:get_component_by_id("find-input"):get_current_value()
    --                         local replace_text = renderer:get_component_by_id("replace-input"):get_current_value()
    --
    --                         -- Trigger replace
    --                         if find_text ~= "" and replace_text ~= "" then
    --                             -- Perform find and replace in the current line
    --                             -- local line_content = vim.api.nvim_get_current_line()
    --
    --                             -- local updated_line = line_content:gsub(find_text, replace_text)
    --                             --
    --                             -- -- Update the line
    --                             -- vim.api.nvim_set_current_line(updated_line)
    --                         end
    --
    --                         signal.is_loading = false
    --                         signal.text = "Replaced: " .. find_text .. " with " .. replace_text
    --                     end, 1000)
    --                 end,
    --             }),
    --             n.spinner({
    --                 is_loading = signal.is_loading,
    --                 padding = { top = 1, left = 1 },
    --                 hidden = signal.is_loading:negate(),
    --             })
    --         ),
    --         n.paragraph({
    --             lines = signal.text,
    --             align = "center",
    --             is_focusable = false,
    --         })
    --     )
    -- end
    --

	local replace_char = vim.fn.input("Replace: ")

	if replace_char == "" then
		return
	end

	local line_content = vim.api.nvim_get_current_line()
	local input_length = #replace_char
	-- Temporarily switch to normal mode and mark the current position
	vim.cmd("normal! <C-o>") -- Go to normal mode briefly
	vim.cmd("normal! ma") -- Mark the current position

	-- Choose the appropriate hop command based on line content
	if line_content == "" then
		require("sj").run({
			pattern_type = "lua_plain",
			forward_search = true,
			separator = "",
			relative_labels = true,
			update_search_register = true,
			seach_scope = "buffer",
			use_last_pattern = false,
			inclusive = true,
		})
	else
		require("sj").run({
			auto_jump = true,
			separator = "",
			pattern_type = "lua_plain",
			forward_search = true,
			relative_labels = true,
			update_search_register = true,
			-- seach_scope = "buffer",
			search_scope = "current_line", --works with other scopes
			use_last_pattern = false,
			inclusive = true,
		})
	end

	-- Actions based on input length
	if input_length >= 2 then
		vim.cmd("normal! ciw") -- Change inner word
		vim.api.nvim_put({ replace_char }, "c", true, true) -- Insert replacement character(s)
		vim.cmd("normal! `a") -- Return to the marked position
		vim.cmd("normal! h") -- Move left (adjust as needed)
		vim.cmd("startinsert")
	elseif input_length == 0 then
		vim.cmd("normal! ciw") -- Start visual selection
		vim.cmd("normal! `a") -- Return to the marked position
	else
		-- Start visual selection
		vim.cmd("normal! v") -- Enter visual mode
		vim.cmd("normal! h") -- Move left (adjust as needed)
		vim.cmd("normal! l") -- Move right (adjust as needed)
		vim.cmd("normal! r" .. replace_char) -- Replace the selected character
		vim.cmd("normal! `a") -- Return to the marked position
		vim.cmd("normal! h") -- Move left (adjust as needed)
	end
    -- renderer:render(body)
end


return M
