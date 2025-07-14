return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		branch = "master",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
			},
		},
		keys = {
			{ "<CR>", desc = "Increment selection" },
			{ "<BS>", desc = "Decrement selection", mode = "x" },
			{
				"gc",
				function()
					require("treesitter-context").go_to_context(vim.v.count1)
				end,
				desc = "Treesitter Go To Context",
			},
		},
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		opts = {
			sync_install = false,
			auto_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true, enable_autocmd = false },
			ensure_installed = {
				"bash",
				"css",
				"json",
				"html",
				"nu",
				"python",
				"query",
				"regex",
				"sql",
				"xml",
				"yaml",
			},
			ignore_install = {},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = false,
					node_decremental = "<BS>",
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
			require("treesitter-context").setup({
				max_lines = 1, -- How many lines the window should span. Values <= 0 mean no limit.
			})
		end,
	},
}
