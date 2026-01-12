return {
	"AlexandrosAlexiou/kotlin.nvim",
	ft = { "kotlin" },
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		{ "stevearc/oil.nvim", opts = {} },
		{ "folke/trouble.nvim", opts = {} },
	},
	config = function()
		-- Sett KOTLIN_LSP_DIR til manuell installasjon
		vim.env.KOTLIN_LSP_DIR = vim.fn.expand("~/opt/kotlin-lsp")

		require("kotlin").setup({
			root_markers = {
				"gradlew",
				".git",
				"mvnw",
				"settings.gradle",
			},
			jre_path = nil,
			jdk_for_symbol_resolution = nil,
			jvm_args = {
				"-Xmx4g",
			},
			inlay_hints = {
				enabled = true,
				parameters = true,
				parameters_compiled = true,
				parameters_excluded = false,
				types_property = true,
				types_variable = true,
				function_return = true,
				function_parameter = true,
				lambda_return = true,
				lambda_receivers_parameters = true,
				value_ranges = true,
				kotlin_time = true,
			},
		})
	end,
}
