-- Theme ui
return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	version = "v1.9.0",
	init = function()
		require("catppuccin").setup({
			hightlight_overrides = {
				mocha = function(colors)
					local overrides = {
						-- Tabline overrides
						MiniTablineCurrent = { fg = colors.yellow, bg = colors.base, style = { "bold" } },
						MiniTablineFill = { bg = colors.mantle },
						MiniTablineHidden = { fg = colors.overlay1, bg = colors.surface0 },
						MiniTablineModifiedCurrent = { fg = colors.base, bg = colors.yellow, style = { "bold" } },
						MiniTablineModifiedHidden = { fg = colors.base, bg = colors.subtext0 },
						MiniTablineModifiedVisible = { fg = colors.base, bg = colors.subtext0, style = { "bold" } },
						MiniTablineTabpagesection = { fg = colors.base, bg = colors.mauve, style = { "bold" } },
						MiniTablineVisible = { fg = colors.overlay1, bg = colors.surface0, style = { "bold" } },

						-- Typescript overrides
						["@keyword.export"] = { fg = colors.mauve },
						["@tag"] = { fg = colors.blue },
						["@tag.builtin"] = { fg = colors.blue },
						["@tag.attribute"] = { fg = colors.yellow },
						["@tag.attribute.tsx"] = { fg = colors.yellow },
					}

					for _, hl in ipairs({ "Headline", "rainbow" }) do
						for i, c in ipairs({ "green", "sapphire", "mauve", "peach", "red", "yellow" }) do
							overrides[hl .. i] = { fg = colors[c], style = { "bold" } }
						end
					end
					return overrides
				end,
			},
		})
		vim.cmd.colorscheme("catppuccin-latte")
	end,
}
