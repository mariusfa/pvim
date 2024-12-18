-- Treesitter = syntax highlights

local opts = {
	ensure_installed = {
		'lua',
		'markdown'
	},
	auto_install = true,
}

local function config()
	require("nvim-treesitter.configs").setup(opts)
end

return {
	"nvim-treesitter/nvim-treesitter",
	version = "v0.9.3",
	build = ":TSUpdate",
	config = config,
}
