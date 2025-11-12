return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("diffview").setup({
			enhanced_diff_hl = true,
		})

		-- Keybindings
		vim.keymap.set("n", "<leader>dv", "<cmd>DiffviewOpen<CR>", { desc = "Open diffview" })
		vim.keymap.set("n", "<leader>dc", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" })
		vim.keymap.set("n", "<leader>dh", "<cmd>DiffviewFileHistory<CR>", { desc = "File history" })
		vim.keymap.set(
			"n",
			"<leader>df",
			"<cmd>DiffviewFileHistory %<CR>",
			{ desc = "Current file history" }
		)
	end,
}
