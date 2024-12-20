local function format()
	require("conform").format({ lsp_format = "fallback" })
end

return {
	"stevearc/conform.nvim",
	version = "v8.2.0",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{ "<leader>cf", format, desc = "Format" },
	},
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			go = { "gofmt" },
			rust = { "rustfmt" },
		},
		format_on_save = {
			lsp_fallbak = true,
			timeout_ms = 500,
		},
	},
}
