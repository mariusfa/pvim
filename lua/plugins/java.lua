return {
	"nvim-java/nvim-java",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("java").setup({
			jdk = { auto_install = false },
			lombok = { enable = false },
			java_test = { enable = true },
			java_debug_adapter = { enable = true },
			spring_boot_tools = { enable = true },
		})
		vim.lsp.enable("jdtls")
	end,
}
