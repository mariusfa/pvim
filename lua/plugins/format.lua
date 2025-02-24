local function format()
	require("conform").format({ lsp_format = "fallback" })
end

-- check if package.json exists in the curren working directory. Then use prettier else use deno fmt
local function getTypescriptFormatter()
	if vim.fn.filereadable("package.json") == 1 then
		return { "prettier" }
	end
	return { "deno_fmt" }
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
			typescript = getTypescriptFormatter(),
			-- typescript = { "deno_fmt", "prettier", stop_after_first = true },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			go = { "gofmt" },
			rust = { "rustfmt" },
			kotlin = { "ktfmt" },
		},
		format_on_save = {
			lsp_fallbak = true,
			timeout_ms = 500,
		},
		formatters = {
			ktfmt = {
				prepend_args = function(self, ctx)
					return { "--kotlinlang-style" }
				end,
			},
		},
	},
}
