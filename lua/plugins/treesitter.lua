-- Treesitter = syntax highlights
return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	main = "nvim-treesitter.configs", -- Sets main module to use for opts
	opts = {
		ensure_installed = {
			"lua",
			"markdown",
			"go",
			"typescript",
			"diff",
			"tsx",
			"html",
			"java",
			"kotlin",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
		},
		indent = { enable = true },
	},
}
