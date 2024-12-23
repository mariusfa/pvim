vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		-- 1. Check if we're editing a commit message
		local filename = vim.fn.expand("%:t") -- e.g. "COMMIT_EDITMSG"
		if filename == "COMMIT_EDITMSG" then
			-- If it's a commit message, do nothing (skip splash)
			return
		end
		local logo_lines = {
			[[███████╗██╗  ██╗██╗████████╗███████╗██╗     ██╗     ██╗     ██╗]],
			[[██╔════╝██║  ██║██║╚══██╔══╝██╔════╝██║     ██║     ██║     ██║]],
			[[███████╗███████║██║   ██║   █████╗  ██║     ██║     ██║     ██║]],
			[[╚════██║██╔══██║██║   ██║   ██╔══╝  ██║     ██║     ██║██   ██║]],
			[[███████║██║  ██║██║   ██║   ███████╗███████╗███████╗██║╚█████╔╝]],
			[[╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚══════╝╚══════╝╚══════╝╚═╝ ╚════╝ ]],
		}
		vim.cmd("enew") -- Create a new empty buffer
		local buf = vim.api.nvim_get_current_buf()

		local max_line_width = vim.fn.strdisplaywidth(logo_lines[1])

		-- Grab the current window’s dimensions
		local win_width = vim.api.nvim_win_get_width(0)
		local win_height = vim.api.nvim_win_get_height(0)

		local pad_top = math.floor((win_height - #logo_lines) / 2)
		local pad_left = math.floor((win_width - max_line_width) / 2)

		-- Build a new table with blank lines and spaces
		local padded_lines = {}

		-- Vertical centering: insert empty lines at the top
		for _ = 1, pad_top do
			table.insert(padded_lines, "")
		end

		-- Horizontal centering: prepend 'pad_left' spaces
		for _, line in ipairs(logo_lines) do
			table.insert(padded_lines, string.rep(" ", pad_left) .. line)
		end

		-- Write everything to our splash buffer
		vim.api.nvim_buf_set_lines(buf, 0, -1, false, padded_lines)

		-- Buffer-local options
		vim.bo[buf].filetype = "nofile"
		vim.bo[buf].buftype = "nofile"
		vim.bo[buf].bufhidden = "wipe"
		vim.bo[buf].swapfile = false
		vim.wo.number = false
		vim.wo.relativenumber = false
		vim.wo.signcolumn = "no"
		vim.wo.foldcolumn = "0"
		vim.wo.cursorline = false

		-- Highlight lines (optional)
		vim.cmd("highlight MyLogoColor guifg=#FFA500 gui=bold")
		for i = pad_top, pad_top + #logo_lines - 1 do
			vim.api.nvim_buf_add_highlight(buf, -1, "MyLogoColor", i, 0, -1)
		end
	end,
})

-- Få tilbake line numbers ved åpning av ny fil
vim.api.nvim_create_autocmd("BufEnter", {
	pattern = "*",
	callback = function()
		-- If this is a real file buffer (not 'nofile', 'prompt', etc.),
		-- enable line numbers. Adjust conditions if needed.
		if vim.bo.buftype == "" and vim.bo.filetype ~= "nofile" then
			vim.wo.number = true
			vim.wo.relativenumber = false -- or true, if you prefer
		end
	end,
})
