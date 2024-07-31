return {
	{
		"echasnovski/mini.diff",
		version = false,
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		keys = {
			{
				"<leader>Gd",
				function()
					require("mini.diff").toggle_overlay(0)
				end,
				desc = "Toggle mini.diff overlay",
			},
		},
		opts = {},
		config = function(_, opts)
			require("mini.diff").setup(opts)
		end,
	},

	{
		"echasnovski/mini-git",
		version = false,
		main = "mini.git",
		event = { "BufReadPost", "BufWritePost", "BufNewFile" },
		opts = {},
		config = function(_, opts)
			require("mini.git").setup(opts)
		end,
	},

	{
		"echasnovski/mini.bufremove",
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
		"echasnovski/mini.files",
		version = "*",
		keys = {
			{
				"<leader>e",
				function()
					local minifiles = require("mini.files")
					local minifiles_toggle = function(...)
						if not minifiles.close() then
							minifiles.open(...)
						end
					end
					minifiles_toggle()
				end,
				desc = "Open MiniFiles",
			},
		},
		opts = {
			mappings = {
				toggle_hidden = "g.",
			},
			content = {
				filter = function(entry)
					return entry.name ~= ".DS_Store" and entry.name ~= ".git" and entry.name ~= "__pycache__"
				end,
			},
		},
		config = function(_, opts)
			require("mini.files").setup(opts)

			local show_dotfiles = true
			local filter_show = function(fs_entry)
				return true
			end

			local filter_hide = function(fs_entry)
				return not vim.startswith(fs_entry.name, ".")
			end

			local toggle_dotfiles = function()
				show_dotfiles = not show_dotfiles
				local new_filter = show_dotfiles and filter_show or filter_hide
				require("mini.files").refresh({ content = { filter = new_filter } })
			end

			vim.api.nvim_create_autocmd("User", {
				pattern = "MiniFilesBufferCreate",
				callback = function(args)
					local buf_id = args.data.buf_id
					vim.keymap.set(
						"n",
						opts.mappings.toggle_hidden,
						toggle_dotfiles,
						{ buffer = buf_id, desc = "MiniFiles Toggle dotfile" }
					)
				end,
			})
		end,
	},

	{
		"echasnovski/mini.pick",
		version = "*",
		keys = {
			{
				"<leader>F",
				function()
					require("mini.pick").builtin.files()
				end,
				desc = "Pick from files",
			},
			{
				"<leader>f",
				function()
					require("mini.pick").builtin.cli({
						command = {
							"rg",
							"--files",
							"--glob",
							"*.{py,csv,css,html,json,xml,fish,lua,js}",
						},
					}, {
						source = {
							name = "Files (rg)",
							show = function(buf_id, items, query)
								require("mini.pick").default_show(buf_id, items, query, { show_icons = true })
							end,
							choose = vim.schedule_wrap(require("mini.pick").default_choose),
						},
					})
				end,
				desc = "Pick from files (cli)",
			},
			{
				"<leader>w",
				function()
					require("mini.pick").builtin.grep()
				end,
				desc = "Pick from pattern matches",
			},
			{
				"<leader>g",
				function()
					require("mini.pick").builtin.grep_live()
				end,
				desc = "Pick from pattern matches with live feedback",
			},
			{
				"<leader>h",
				function()
					require("mini.pick").builtin.help()
				end,
				desc = "Pick from help tags",
			},
			{
				"<leader><leader>",
				function()
					require("mini.pick").builtin.buffers()
				end,
				desc = "Pick from buffers",
			},
			{
				"<leader>r",
				function()
					require("mini.pick").builtin.resume()
				end,
				desc = "Resume latest picker",
			},
		},
		opts = {
			mappings = {
				move_down = "<C-j>",
				move_up = "<C-k>",
			},
		},
		config = function(_, opts)
			require("mini.pick").setup(opts)
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
		---@type Flash.Config
		opts = {},
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
	},

	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
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
			{ "<leader>T", "<cmd>Trouble todo toggle focus=true<cr>", desc = "Todo (Trouble)" },
			{
				"<leader>t",
				"<cmd>Trouble todo toggle filter={tag={TODO,FIX,FIXME,NOTE,HACK}} focus=true<cr>",
				desc = "Todo/Fix/Fixme/Note/Hack (Trouble)",
			},
		},
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"gd",
				"<cmd>Trouble lsp_definitions toggle focus=true<cr>",
				desc = "LSP Definitions (Trouble)",
			},
			{
				"gD",
				"<cmd>Trouble lsp_declarations toggle focus=true<cr>",
				desc = "LSP Declarations (Trouble)",
			},
			{
				"gr",
				"<cmd>Trouble lsp_references toggle focus=true<cr>",
				desc = "LSP References (Trouble)",
			},
			{
				"<leader>d",
				"<cmd>Trouble diagnostics toggle  focus=true filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>D",
				"<cmd>Trouble diagnostics toggle focus=true<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>s",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>l",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>q",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>Q",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
}
