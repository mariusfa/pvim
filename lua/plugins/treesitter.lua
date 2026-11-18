local ensure_installed = {
	"lua",
	"markdown",
	"markdown_inline",
	"go",
	"typescript",
	"diff",
	"tsx",
	"html",
	"java",
	-- "kotlin", -- Bruker kotlin.nvim i stedet
	"python",
}

local function start(buf)
	if pcall(vim.treesitter.start, buf) then
		vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end
end

-- Treesitter = syntax highlights
return { -- Highlight, edit, and navigate code
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		ts.install(ensure_installed)

		vim.api.nvim_create_autocmd("FileType", {
			desc = "Start treesitter and install missing parsers",
			group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
			callback = function(args)
				local lang = vim.treesitter.language.get_lang(args.match)
				if not lang then
					return
				end
				if vim.tbl_contains(ts.get_installed(), lang) or not vim.tbl_contains(ts.get_available(), lang) then
					start(args.buf)
					return
				end

				-- install async, then start treesitter when parsers are built
				ts.install({ lang }):await(vim.schedule_wrap(function()
					if vim.api.nvim_buf_is_valid(args.buf) then
						start(args.buf)
					end
				end))
			end,
		})
	end,
}
