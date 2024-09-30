return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {},
		cmd = "FzfLua",
		keys = {
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
			{
				"<leader>sg",
				function()
					require("fzf-lua").live_grep_native()
				end,
				desc = "Fzf Live Grep",
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
					require("fzf-lua").keys()
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
				"__pycache__",
				"%.docx",
				"%.h5",
				"%.hdf5",
				"%.ipynb",
				"%.jpg",
				"%.pdf",
				"%.png",
				"%.pt",
				"%.pth",
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
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {
			signs = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			signs_staged = {
				add = { text = "▎" },
				change = { text = "▎" },
				delete = { text = "" },
				topdelete = { text = "" },
				changedelete = { text = "▎" },
				untracked = { text = "▎" },
			},
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

				map("n", "]h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "]c", bang = true })
					else
						gs.nav_hunk("next")
					end
				end, "Next Hunk")

				map("n", "[h", function()
					if vim.wo.diff then
						vim.cmd.normal({ "[c", bang = true })
					else
						gs.nav_hunk("prev")
					end
				end, "Prev Hunk")

				map("n", "]H", function()
					gs.nav_hunk("last")
				end, "Last Hunk")

				map("n", "[H", function()
					gs.nav_hunk("first")
				end, "First Hunk")

				map("n", "<leader>gd", gs.diffthis, "Diff This")

				map("n", "<leader>gD", function()
					gs.diffthis("~")
				end, "Diff This ~")
			end,
		},
		config = function(_, opts)
			require("gitsigns").setup(opts)
		end,
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

	{
		"folke/flash.nvim",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble" },
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		keys = {
			{
				"]x",
				function()
					require("todo-comments").jump_next()
				end,
				desc = "Next Todo Comment",
			},
			{
				"[x",
				function()
					require("todo-comments").jump_prev()
				end,
				desc = "Previous Todo Comment",
			},
			{
				"<leader>st",
				function()
					require("todo-comments.fzf").todo()
				end,
				desc = "Todo (Trouble)",
			},
			{
				"<leader>sT",
				function()
					require("todo-comments.fzf").todo({ keywords = { "TODO", "FIX", "FIXME", "NOTE" } })
				end,
				desc = "Todo/Fix/Fixme/Note",
			},
		},
	},
}
