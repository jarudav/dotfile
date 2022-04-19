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
		prompt_prefix = "  ",
		selection_caret = " ",
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
		file_browser = {},
	},
})

telescope.load_extension("file_browser")
