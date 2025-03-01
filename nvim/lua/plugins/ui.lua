return {
	{
		"echasnovski/mini.icons",
		version = false,
		lazy = true,
		opts = {},
		init = function()
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},

	{
		"echasnovski/mini.animate",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		config = function(_, opts)
			require("mini.animate").setup(opts)
		end,
	},

	{
		"echasnovski/mini.tabline",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		config = function(_, opts)
			require("mini.tabline").setup(opts)
		end,
	},

	{
		"norcalli/nvim-colorizer.lua",
		version = "*",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = { "*" },
		config = function(_, opts)
			require("colorizer").setup(opts, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				names = true, -- "Name" codes like Blue
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
				-- Available modes: foreground, background
				mode = "background", -- Set the display mode.
			})
		end,
	},

	{
		"echasnovski/mini.statusline",
		version = false,
		opts = {
			set_vim_settings = false,
		},
		config = function(_, opts)
			require("mini.statusline").setup(opts)
		end,
	},
}
