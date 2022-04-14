local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " }, --, info = " ", hint = " " },
	colored = true,
	always_visible = true,
}

local diff = {
	"diff",
	colored = true,
	diff_color = {
		added = { fg = "#145A32" },
		modified = { fg = "#FF5733" },
		removed = { fg = "#C70039" },
	},
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
}

local filename = {
	"filename",
	file_status = true,
	path = 0,
	symbols = {
		modified = "[+]", -- Text to show when the file is modified.
		readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
		unnamed = "[No Name]", -- Text to show for unnamed buffers.
	},
}

local filetype = {
	"filetype",
	colored = true,
	icons_enabled = true,
}

local mode = {
	"mode",
	fmt = function(str)
		return " " .. str .. " "
	end,
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "tokyonight",
		-- section_separators = { left = "", right = "" },
		-- component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		component_separators = { left = "|", right = "|" },
		disabled_filetypes = {},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { mode },
		lualine_b = { branch, diff, diagnostics },
		lualine_c = { filename },
		lualine_x = { spaces, "encoding", filetype },
		lualine_y = { "location" },
		lualine_z = { "progress" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { filename },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
