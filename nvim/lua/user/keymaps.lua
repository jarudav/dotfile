local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap("n", "<esc><esc>", ":nohlsearch<CR>", opts)

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
keymap("n", "ff", builtin.find_files, opts)
keymap("n", "fb", builtin.buffers, opts)
keymap("n", "fg", function()
	builtin.live_grep({ grep_open_files = true })
end, opts)
keymap("n", "fs", builtin.grep_string, opts)
keymap("n", "fh", builtin.help_tags, opts)
keymap("n", "<space>q", function()
	builtin.diagnostics({ bufnr = 0 }, opts)
end)

-- LSPsaga
keymap("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
keymap("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "gd", "<Cmd>Lspsaga goto_definition<CR>", opts)
keymap("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
keymap("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
keymap("n", "<space>e", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>", opts)
keymap("n", "<space>o", "<cmd>Lspsaga outline<CR>")
keymap("n", "<space>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<space>co", "<cmd>Lspsaga outgoing_calls<CR>")

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Bufferline
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "[b", ":BufferLineMovePrev<CR>", opts)
keymap("n", "]b", ":BufferLineMoveNext<CR>", opts)

-- ToggleTerm
keymap("n", "<space>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<space>ip", "<cmd>lua _IPYTHON_TOGGLE()<CR>", opts)
keymap("n", "<space>\\", "<cmd>lua _VERTICAL_TOGGLE()<CR>", opts)
keymap("n", "<space>kt", "<cmd>4ToggleTerm<CR>", opts)
keymap("n", "<space>sl", ":ToggleTermSendCurrentLine 2<CR>", opts)
keymap("v", "<space>sl", ":ToggleTermSendVisualLines 2<CR>", opts)
