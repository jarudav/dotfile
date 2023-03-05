local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
	defaults = {
		path_display = { "smart" },
		file_ignore_patterns = { "__pycache__", "%.pyc", "*.DS_Store" },
		layout_config = { prompt_position = "top" },
		sorting_strategy = "ascending",
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<C-w>"] = actions.delete_buffer,
			},
			n = {
				["q"] = actions.close,
				["w"] = actions.delete_buffer,
			},
		},
	},
	extensions = {
		fzf = {},
		file_browser = {
			-- theme = "dropdown",
			initial_mode = "normal",
			path = "%:p:h",
			grouped = true,
			-- disables netrw and use telescope-file-browser in its place
			hijack_netrw = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
					["<C-d>"] = fb_actions.remove,
					["<C-r>"] = fb_actions.rename,
					["<C-y>"] = fb_actions.copy,
				},
				["n"] = {
					["h"] = fb_actions.goto_home_dir,
					["p"] = fb_actions.goto_parent_dir,
					-- your custom normal mode mappings
				},
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("file_browser")
