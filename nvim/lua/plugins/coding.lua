return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind-nvim",
		},
		opts = function()
			local cmp = require("cmp")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert",
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<S-CR>"] = cmp.mapping.confirm({
						behavior = cmp.ConfirmBehavior.Replace,
						select = true,
					}),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
					{ name = "path" },
				}),
				formatting = {
					format = require("lspkind").cmp_format({
						mode = "symbol",
						maxwidth = 50,
					}),
				},
			}
		end,
	},

	{
		"echasnovski/mini.pairs",
		version = "*",
		event = "InsertEnter",
		opts = {},
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},

	{
		"echasnovski/mini.surround",
		version = "*",
		event = "InsertEnter",
		opts = {},
		config = function(_, opts)
			require("mini.surround").setup(opts)
		end,
	},

	{
		"echasnovski/mini.bracketed",
		version = "*",
		event = "BufReadPost",
		opts = {},
		config = function(_, opts)
			require("mini.bracketed").setup(opts)
		end,
	},

	{
		"smjonas/inc-rename.nvim",
		keys = {
			{
				"<leader>rn",
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
