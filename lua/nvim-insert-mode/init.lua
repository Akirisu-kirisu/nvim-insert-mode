local M = {}
-- local line_content = vim.api.nvim_get_current_line

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
		vim.cmd("HopAnywhere") -- Hop to the desired position
	else
		vim.cmd("HopAnywhereCurrentLine") -- Hop to the desired position
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
	-- Get user input for the replacement character

	local replace_char = vim.fn.input("Replace with: ")

    if replace_char == '' then
        return
    end

	local line_content = vim.api.nvim_get_current_line()
	local input_length = #replace_char
	-- Temporarily switch to normal mode and mark the current position
	vim.cmd("normal! <C-o>") -- Go to normal mode briefly
	vim.cmd("normal! ma") -- Mark the current position

	-- Choose the appropriate hop command based on line content
	if line_content == "" then
		vim.cmd("HopAnywhere") -- Hop to the desired position
	else
		vim.cmd("HopAnywhereCurrentLine") -- Hop to the desired position
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
end

return M
