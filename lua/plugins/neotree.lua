return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "3.38.0",
	opts = {
		popup_border_style = "rounded",
		window = {
			position = "float",
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
			},
		},
		filesystem = {
			filtered_items = { hide_dotfiles = false, hide_gitignore = false },
		},
	},
	keys = {
		{
			"<leader>e",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), reveal = true })
			end,
			desc = "Explorer NeoTree (cwd)",
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
}
