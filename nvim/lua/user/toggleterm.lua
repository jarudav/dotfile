local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	open_mapping = [[<c-\>]],
	shade_filetypes = {},
	direction = "horizontal",
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	float_opts = { border = "rounded", winblend = 0 },
	size = function(term)
		if term.direction == "horizontal" then
			return 15
		elseif term.direction == "vertical" then
			return vim.o.columns * 0.4
		end
	end,
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local ipython = Terminal:new({ cmd = "ipython", count = 2, hidden = true, direction = "vertical" })
function _IPYTHON_TOGGLE()
	ipython:toggle()
end

local lazygit = Terminal:new({ cmd = "lazygit", count = 3, hidden = true, direction = "float" })
function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

function _RUN_PYTHON()
	vim.cmd("TermExec cmd='python %:p'")
end
