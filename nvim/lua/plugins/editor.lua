return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {},
		cmd = "FzfLua",
		keys = {
			-- file & buffer
			{
				"<leader><leader>",
				function()
					require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true })
				end,
				desc = "Fzf Switch Buffer",
			},
			{
				"<leader>ff",
				function()
					require("fzf-lua").files()
				end,
				desc = "Fzf Files",
			},
			{
				"<leader>fF",
				function()
					require("fzf-lua").files({ cwd = "%:p:h" })
				end,
				desc = "Fzf Files (cwd)",
			},
			{
				"<leader>fg",
				function()
					require("fzf-lua").git_files()
				end,
				desc = "Fzf Files (git-files)",
			},
			-- git
			{
				"<leader>gc",
				function()
					require("fzf-lua").git_commits()
				end,
				desc = "Fzf Commits",
			},
			{
				"<leader>gs",
				function()
					require("fzf-lua").git_status()
				end,
				desc = "Fzf Status",
			},
			-- search
			{
				"<leader>sg",
				function()
					require("fzf-lua").live_grep_native()
				end,
				desc = "Fzf Live Grep",
			},
			{
				"<leader>sr",
				function()
					require("fzf-lua").live_grep_resume()
				end,
				desc = "Fzf Live Grep Continue Last Search",
			},
			{
				"<leader>sG",
				function()
					require("fzf-lua").live_grep_native()
				end,
				desc = "Fzf Grep",
			},
			{
				"<leader>sw",
				function()
					require("fzf-lua").grep_cword()
				end,
				desc = "Fzf Grep word",
			},
			{
				"<leader>/",
				function()
					require("fzf-lua").lgrep_curbuf()
				end,
				desc = "Fzf Live Grep Current Buffer",
			},
			{
				"<leader>sj",
				function()
					require("fzf-lua").jumps()
				end,
				desc = "Fzf Jumps List",
			},
			{
				"<leader>sk",
				function()
					require("fzf-lua").keymaps()
				end,
				desc = "Fzf Key Maps",
			},
			{
				"<leader>sb",
				function()
					require("fzf-lua").builtin()
				end,
				desc = "Fzf Files (git-files)",
			},
			{
				"<leader>sh",
				function()
					require("fzf-lua").search_history()
				end,
				desc = "Fzf Search History",
			},
			-- lsp
			{
				"gd",
				function()
					require("fzf-lua").lsp_definitions({ jump_to_single_result = true, ignore_current_line = true })
				end,
				desc = "Fzf Goto Definition",
			},
			{
				"gr",
				function()
					require("fzf-lua").lsp_references({
						jump_to_single_result = true,
						ignore_current_line = true,
						includeDeclaration = false,
					})
				end,
				desc = "Fzf Goto Definition",
			},
			{
				"<leader>d",
				function()
					require("fzf-lua").lsp_document_diagnostics()
				end,
				desc = "Fzf Document Diagnostics",
			},
			{
				"<leader>D",
				function()
					require("fzf-lua").lsp_workspace_diagnostics()
				end,
				desc = "Fzf Workspace Diagnostics",
			},
			{
				"<leader>ss",
				function()
					require("fzf-lua").lsp_document_symbols({})
				end,
				desc = "Goto Symbol",
			},
			{
				"<leader>sS",
				function()
					require("fzf-lua").lsp_live_workspace_symbols({})
				end,
				desc = "Goto Symbol (Workspace)",
			},
		},
		opts = {
			"max-perf",
			file_ignore_patterns = {
				"%.DS_Store$",
				"tmp/",
				"__pycache__",
				"%.docx",
				"%.geojson",
				"%.h5",
				"%.hdf5",
				"%.ipynb",
				"%.jpg",
				"%.pdf",
				"%.png",
				"%.pt",
				"%.pth",
				"%.xlxs",
				"%.zip",
			},
			winopts = {
				preview = { default = "bat_native" },
			},
			keymap = {
				builtin = {
					["<c-f>"] = "preview-page-down",
					["<c-b>"] = "preview-page-up",
				},
				fzf = {
					["ctrl-d"] = "half-page-down",
					["ctrl-u"] = "half-page-up",
					["ctrl-f"] = "preview-page-down",
					["ctrl-b"] = "preview-page-up",
				},
			},
		},
		config = function(_, opts)
			require("fzf-lua").setup(opts)
		end,
	},

	{
		"echasnovski/mini.diff",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			view = {
				style = "sign",
			},
		},
		config = function(_, opts)
			require("mini.diff").setup(opts)
		end,
	},

	{
		"echasnovski/mini.indentscope",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		config = function(_, opts)
			require("mini.indentscope").setup(opts)
		end,
	},

	{
		"echasnovski/mini.bufremove",
		version = false,
		keys = {
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
		end,
	},
}
