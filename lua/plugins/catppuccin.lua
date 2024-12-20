-- Theme ui
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	version = "v1.9.0",
	init = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
