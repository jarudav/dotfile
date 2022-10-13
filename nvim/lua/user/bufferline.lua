local status, bufferline = pcall(require, "bufferline")
if not status then
	return
end

bufferline.setup({
	options = {
		color_icons = true,
		show_close_icon = false,
		show_buffer_close_icons = false,
		diagnostics = "nvim_lsp",
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "PanelHeading",
			},
		},
	},
})
