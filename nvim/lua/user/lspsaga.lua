local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.init_lsp_saga({
	border_style = "rounded",
	move_in_saga = { prev = "<C-k>", next = "<C-j>" },
	finder_action_keys = {
		open = "o",
		vsplit = "v",
		split = "x",
		tabe = "t",
		quit = "q",
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	definition_action_keys = {
		edit = "<C-c>o",
		vsplit = "<C-c>v",
		split = "<C-c>x",
		tabe = "<C-c>t",
		quit = "q",
	},
})
