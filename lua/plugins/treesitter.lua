-- Treesitter = syntax highlights

local opts = {
	ensure_installed = {
		"lua",
		"markdown",
		"go",
		"typescript",
		"tsx",
	},
	auto_install = true,
}

local function config()
	require("nvim-treesitter.configs").setup(opts)
end

return {
	"nvim-treesitter/nvim-treesitter",
	tag = "v0.9.3",
	build = ":TSUpdate",
	config = config,
}
