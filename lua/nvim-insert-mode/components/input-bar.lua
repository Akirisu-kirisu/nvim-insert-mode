local M = {}
local n = require("nui-components")

-- Create the renderer
M.renderer = n.create_renderer({
	width = 60,
	height = 12,
})

-- Create a signal for state management
M.signal = n.create_signal({
	is_checked = false,
	text = "",
})

-- Define the body of the NUI component
M.body = function()
	return n.rows(n.rows(
		{
			flex = 1,
		},
		n.text_input({
			flex = 1,
			value = M.signal.text,
			on_change = function(value)
				M.signal.text = value
			end,
		}),
		n.button({
			label = "Replace Character",
			on_click = function()
				if M.search_char and #M.search_char > 0 then
                    local replace_char = vim.fn.input("Replace with: ")
                    M.text = M.text:gsub(M.search_char, replace_char)
				end
			end,
		})
	))
end

-- Render the body
M.renderer:render(M.body)

-- Return the module
return M
