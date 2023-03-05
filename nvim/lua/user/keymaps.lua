local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

vim.g.mapleader = ";"

keymap("n", "<leader>n", ":nohlsearch<CR>", opts)

-- Navigate window
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Resize  window
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
keymap("n", "<leader>bd", ":bd<CR>", opts)

-- Move line
keymap("n", "<C-s>j", ":m .+1<CR>==", opts)
keymap("n", "<C-s>k", ":m .-2<CR>==", opts)
keymap("v", "<C-s>j", ":m '>+1<CR>gv=gv", opts)
keymap("i", "<C-s>j", "<Esc>:m .+1<CR>==gi", opts)
keymap("i", "<C-s>k", "<Esc>:m .-2<CR>==gi", opts)
keymap("v", "<C-s>k", ":m '<-2<CR>gv=gv", opts)

-- annoy keybind
keymap("", "J", "<Nop>", opts)

-- Telescope
local builtin = require("telescope.builtin")
keymap("n", "<leader>f", builtin.find_files, opts)
keymap("n", "<leader>b", builtin.buffers, opts)
keymap("n", "<leader>g", builtin.live_grep, opts)
keymap("n", "<leader>s", builtin.grep_string, opts)
keymap("n", "<leader>h", builtin.help_tags, opts)
keymap("n", "<leader>;", builtin.current_buffer_fuzzy_find, opts)
vim.keymap.set("n", "<leader>e", function()
	require("telescope").extensions.file_browser.file_browser({})
end)

-- LSPsaga
keymap("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "<leader>q", "<Cmd>Lspsaga show_buf_diagnostics<CR>", opts)
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", opts)
keymap("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")
keymap("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- Bufferline
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "[b", ":BufferLineMovePrev<CR>", opts)
keymap("n", "]b", ":BufferLineMoveNext<CR>", opts)

-- ToggleTerm
-- keymap("n", "<leader>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
-- keymap("n", "<leader>ip", "<cmd>lua _IPYTHON_TOGGLE()<CR>", opts)
-- keymap("n", "<leader>s", ":ToggleTermSendCurrentLine 2<CR>", opts)
-- keymap("v", "<leader>s", ":ToggleTermSendVisualLines 2<CR>", opts)
