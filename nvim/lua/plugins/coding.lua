return {
	{
		"echasnovski/mini.completion",
		version = false,
		event = { "InsertEnter" },
		opts = {},
		config = function(_, opts)
			require("mini.completion").setup(opts)
		end,
	},

	{
		"echasnovski/mini.pairs",
		version = false,
		event = "InsertEnter",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},

	{
		"echasnovski/mini.surround",
		version = false,
		event = "InsertEnter",
		opts = {},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
	},

	{
		"echasnovski/mini.bracketed",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			conflict = { suffix = "" },
			diagnostic = { suffix = "" },
			file = { suffix = "" },
		},
		config = function(_, opts)
			require("mini.bracketed").setup(opts)
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		keys = {
			{
				"<leader>r",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				expr = true,
				desc = "Rename",
			},
		},
		config = function()
			require("inc_rename").setup()
		end,
	},
}
