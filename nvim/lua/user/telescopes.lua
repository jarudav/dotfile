local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local status, actions = pcall(require, "telescope.actions")
if not status then
	return
end

telescope.setup({
	defaults = {
		path_display = { "smart" },
		file_ignore_patterns = { "%.pyc" },
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
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("fzf")
