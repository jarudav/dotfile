local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
	return
end

local function diagnostics_indicator(_, _, diagnostics)
	local symbols = { error = " ", warning = " ", info = " " }
	local result = {}
	for name, count in pairs(diagnostics) do
		if symbols[name] and count > 0 then
			table.insert(result, symbols[name] .. count)
		end
	end
	result = table.concat(result, " ")
	return #result > 0 and result or ""
end

bufferline.setup({
	options = {
		sort_by = "insert_after_current",
		show_close_icon = false,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = diagnostics_indicator,
		offsets = {
			{
				filetype = "NvimTree",
				text = "File Explorer",
				highlight = "PanelHeading",
			},
		},
	},
})
