-- Remember to do require this file before plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "JJ", "<Esc>", { noremap = true })
-- Indent right and keep text selected
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true })
-- Indent left and keep text selected
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true })
-- Shiftwitdh and softtabstop set to 4
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4

vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeOpen<CR>", { noremap = true, silent = true })

vim.opt.number = true

vim.opt.mouse = "a"

vim.opt.clipboard = "unnamedplus"

-- save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })

vim.keymap.set("t", "jj", "<C-\\><C-n>", { desc = "Exit terminal mode" })
vim.keymap.set("t", "JJ", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- autoformat
vim.g.autoformat = true
vim.api.nvim_create_user_command("FormatDisable", function()
	vim.g.autoformat = false
end, {
	desc = "Disable autoformat-on-save",
})

vim.api.nvim_create_user_command("FormatEnable", function()
	vim.g.autoformat = true
end, {
	desc = "Re-enable autoformat-on-save",
})
