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

local function formatOnSave()
	if vim.g.autoformat then
		print("Autoformat enabled")
		return { timeout_ms = 500, lsp_format = "fallback" }
	end
	print("Autoformat disabled")
end

return {
	"stevearc/conform.nvim",
	version = "v9.0.0",
	event = "BufWritePre",
	cmd = "ConformInfo",
	keys = {
		{ "<leader>cf", format, desc = "Format" },
	},
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				typescript = getTypescriptFormatter,
				typescriptreact = { "prettier" },
				json = { "prettier" },
				go = { "gofmt" },
				rust = { "rustfmt" },
				-- kotlin = { "ktfmt" }, -- Bruker LSP (kotlin.nvim) i stedet
				kotlin = { lsp_format = "prefer" },
				python = { "black" },
			},
			format_on_save = function(bufnr)
				if vim.g.autoformat then
					print("Autoformat enabled")
					return { timeout_ms = 500, lsp_format = "fallback" }
				end
				print("Autoformat disabled")
			end,
			formatters = {
				ktfmt = {
					prepend_args = function(self, ctx)
						return { "--kotlinlang-style" }
					end,
				},
			},
		})
	end,
	-- opts = {
	-- 	formatters_by_ft = {
	-- 		lua = { "stylua" },
	-- 		typescript = getTypescriptFormatter(),
	-- 		-- typescript = { "deno_fmt", "prettier", stop_after_first = true },
	-- 		typescriptreact = { "prettier" },
	-- 		json = { "prettier" },
	-- 		go = { "gofmt" },
	-- 		rust = { "rustfmt" },
	-- 		kotlin = { "ktfmt" },
	-- 	},
	--
	-- 	format_on_save = function(bufnr)
	-- 		if vim.g.autoformat then
	-- 			print("Autoformat enabled")
	-- 			return { timeout_ms = 500, lsp_format = "fallback" }
	-- 		end
	-- 		print("Autoformat disabled")
	-- 	end,
	-- 	formatters = {
	-- 		ktfmt = {
	-- 			prepend_args = function(self, ctx)
	-- 				return { "--kotlinlang-style" }
	-- 			end,
	-- 		},
	-- 	},
	-- },
}
