return {
	{
		"echasnovski/mini.diff",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = function(_, opts)
			require("mini.diff").setup(opts)
		end,
	},

	{
		"echasnovski/mini.hipatterns",
		version = "*",
		event = "BufReadPre",
		opts = function()
			local hipatterns = require("mini.hipatterns")
			return {
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			}
		end,
		config = function(_, opts)
			require("mini.hipatterns").setup(opts)
		end,
	},

	{
		"echasnovski/mini.cursorword",
		version = "*",
		event = "BufReadPre",
		config = function()
			require("mini.cursorword").setup()
		end,
	},

	-- buffer remove
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
				";e",
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
		"folke/trouble.nvim",
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
				";D",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				";d",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				";s",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				";l",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				";q",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				";Q",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
		opts = {}, -- for default options, refer to the configuration section for custom setup.
	},

	{
		"echasnovski/mini.pick",
		version = "*",
		keys = {
			{
				";F",
				function()
					require("mini.pick").builtin.files()
				end,
				desc = "Pick from files",
			},
			{
				";f",
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
				";w",
				function()
					require("mini.pick").builtin.grep()
				end,
				desc = "Pick from pattern matches",
			},
			{
				";g",
				function()
					require("mini.pick").builtin.grep_live()
				end,
				desc = "Pick from pattern matches with live feedback",
			},
			{
				";b",
				function()
					require("mini.pick").builtin.buffer()
				end,
				desc = "Pick from buffers",
			},
			{
				";r",
				function()
					require("mini.pick").builtin.resume()
				end,
				desc = "Resume latest picker",
			},
		},
		opts = {},
		config = function(_, opts)
			require("mini.pick").setup(opts)
		end,
	},
}
