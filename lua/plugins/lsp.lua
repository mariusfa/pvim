return {
	"neovim/nvim-lspconfig",
	version = "v2.1.0",
	dependencies = {
		{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
		"williamboman/mason-lspconfig.nvim",

		"WhoIsSethDaniel/mason-tool-installer.nvim",

		{ "j-hui/fidget.nvim", opts = {} },

		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

				map("<leader>cr", vim.lsp.buf.rename, "[R]e[n]ame")
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
				map("<leader>co", function()
					vim.lsp.buf.code_action({
						-- only run the "source.organizeImports" action
						context = {
							only = { "source.organizeImports" },
						},
						-- apply immediately (skip the selection window)
						apply = true,
					})
				end, "[C]ode [O]rganize Imports")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--    See `:help CursorHold` for information about when this is executed
				--
				-- TODO: fjern dette hvis ikke oppdages at er behov
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				-- local client = vim.lsp.get_client_by_id(event.data.client_id)
				-- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				--   local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
				--   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
				--     buffer = event.buf,
				--     group = highlight_augroup,
				--     callback = vim.lsp.buf.document_highlight,
				--   })
				--
				--   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
				--     buffer = event.buf,
				--     group = highlight_augroup,
				--     callback = vim.lsp.buf.clear_references,
				--   })
				--
				--   vim.api.nvim_create_autocmd('LspDetach', {
				--     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
				--     callback = function(event2)
				--       vim.lsp.buf.clear_references()
				--       vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
				--     end,
				--   })
				-- end

				-- The following code creates a keymap to toggle inlay hints in your
				-- code, if the language server you are using supports them
				--
				-- This may be unwanted, since they displace some of your code
				-- Hvis jeg ikke ser forsjell uten dette, så fjern etterhvert. 2025
				-- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				--   map('<leader>th', function()
				--     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
				--   end, '[T]oggle Inlay [H]ints')
				-- end
			end,
		})

		if vim.g.have_nerd_font then
			local signs = { ERROR = "", WARN = "", INFO = "", HINT = "" }
			local diagnostic_signs = {}
			for type, icon in pairs(signs) do
				diagnostic_signs[vim.diagnostic.severity[type]] = icon
			end
			vim.diagnostic.config({ signs = { text = diagnostic_signs } })
		end

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

		-- Enable the following language servers
		--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
		--
		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		--
		local nvim_lsp = require("lspconfig")
		local servers = {
			gopls = {},
			rust_analyzer = {},
			ts_ls = {
				-- root_dir = nvim_lsp.util.root_pattern("package.json"),
				-- single_file_support = false,
			},
			-- denols = {
			-- 	root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc"),
			-- },
			tailwindcss = {},
			kotlin_language_server = {},
			basedpyright = {},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						diagnostics = { disable = { "missing-fields" } },
					},
				},
			},
		}

		require("mason").setup()

		-- You can add other tools here that you want Mason to install
		-- for you, so that they are available from within Neovim.
		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format Lua code
			"prettier", -- Used to format JavaScript, TypeScript, etc.
			"ktfmt", -- Used to format Kotlin code
			"black", -- Used to format Python code
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		require("mason-lspconfig").setup({
			handlers = {
				function(server_name)
					local server = servers[server_name] or {}
					-- This handles overriding only values explicitly passed
					-- by the server configuration above. Useful when disabling
					-- certain features of an LSP (for example, turning off formatting for ts_ls)
					server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
					require("lspconfig")[server_name].setup(server)
				end,
			},
		})
	end,
}
