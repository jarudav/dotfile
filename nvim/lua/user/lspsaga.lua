local status_ok, lspsaga = pcall(require, "lspsaga")
if not status_ok then
	return
end

lspsaga.init_lsp_saga({
	error_sign = "",
	warn_sign = "",
	hint_sign = "",
	infor_sign = "",
	finder_action_keys = {
		open = "<CR>",
		vsplit = "<C-v>",
		split = "<C-x>",
		quit = "q",
		scroll_down = "<C-d>",
		scroll_up = "<C-u>",
	},
	border_style = "round",
})
