local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions_status_ok, actions = pcall(require, "telescope.actions")
if not actions_status_ok then
	return
end

telescope.setup({
	defaults = {
		path_display = { "smart" },
		file_ignore_patterns = { "%.pyc" },
		mappings = {
			i = {},

			n = {
				["q"] = actions.close,
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
