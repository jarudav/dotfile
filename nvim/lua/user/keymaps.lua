local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<esc><esc>", ":nohlsearch<CR>", opts)

-- Navigate window
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

-- Resize  window
vim.keymap.set("n", "<S-Up>", ":resize +2<CR>", opts)
vim.keymap.set("n", "<S-Down>", ":resize -2<CR>", opts)
vim.keymap.set("n", "<S-Left>", ":vertical resize -2<CR>", opts)
vim.keymap.set("n", "<S-Right>", ":vertical resize +2<CR>", opts)

-- Buffers
vim.keymap.set("n", "<leader>bd", ":bd<CR>", opts)

-- Move line
vim.keymap.set("n", "<C-s>j", ":m .+1<CR>==", opts)
vim.keymap.set("n", "<C-s>k", ":m .-2<CR>==", opts)
vim.keymap.set("v", "<C-s>j", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("i", "<C-s>j", "<Esc>:m .+1<CR>==gi", opts)
vim.keymap.set("i", "<C-s>k", "<Esc>:m .-2<CR>==gi", opts)
vim.keymap.set("v", "<C-s>k", ":m '<-2<CR>gv=gv", opts)

-- annoy keybind
vim.keymap.set("", "J", "<Nop>", opts)

-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "ff", builtin.find_files, opts)
vim.keymap.set("n", "fb", builtin.buffers, opts)
vim.keymap.set("n", "fg", builtin.live_grep, opts)
vim.keymap.set("n", "fs", builtin.grep_string, opts)
vim.keymap.set("n", "fh", builtin.help_tags, opts)
vim.keymap.set("n", "<space>q", function()
	builtin.diagnostics({ bufnr = 0 }, opts)
end)
vim.keymap.set("n", "gi", builtin.lsp_implementations, opts)

-- LSPsaga
vim.keymap.set("n", "[d", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "]d", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga peek_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "<space>e", "<Cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set({ "n", "v" }, "ga", "<cmd>Lspsaga code_action<CR>", opts)

-- NvimTree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Bufferline
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "[b", ":BufferLineMovePrev<CR>", opts)
vim.keymap.set("n", "]b", ":BufferLineMoveNext<CR>", opts)

-- ToggleTerm
vim.keymap.set("n", "<space>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
vim.keymap.set("n", "<space>ip", "<cmd>lua _IPYTHON_TOGGLE()<CR>", opts)
vim.keymap.set("n", "<space>\\", "<cmd>lua _VERTICAL_TOGGLE()<CR>", opts)
vim.keymap.set("n", "<space>kt", "<cmd>4ToggleTerm<CR>", opts)
vim.keymap.set("n", "<space>sl", ":ToggleTermSendCurrentLine 2<CR>", opts)
vim.keymap.set("v", "<space>sl", ":ToggleTermSendVisualLines 2<CR>", opts)

-- DAP
-- vim.keymap.set("n", "<space>db", require("dap").continue, opts)
-- vim.keymap.set("n", "<space>dc", require("dap").close, opts)
-- vim.keymap.set("n", "<space>dq", require("dapui").toggle, opts)
-- vim.keymap.set("n", "<space>b", require("dap").toggle_breakpoint, opts)
-- vim.keymap.set("n", "<space>n", require("dap").step_over, opts)
-- vim.keymap.set("n", "<space>i", require("dap").step_into, opts)
