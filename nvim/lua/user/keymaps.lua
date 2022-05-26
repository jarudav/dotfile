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
function TelescopeFiles()
	local telescope_opts = { previewer = false }
	local ok = pcall(require("telescope.builtin").git_files, telescope_opts)
	if not ok then
		require("telescope.builtin").find_files(telescope_opts)
	end
end
vim.keymap.set("n", "<space>f", TelescopeFiles)

vim.keymap.set("n", "<space><space>", function()
	require("telescope.builtin").buffers({ sort_lastused = true })
end, opts)
vim.keymap.set("n", "<space>sl", require("telescope.builtin").live_grep, opts)
vim.keymap.set("n", "<space>sg", require("telescope.builtin").grep_string, opts)
vim.keymap.set("n", "<space>h", require("telescope.builtin").help_tags, opts)
vim.keymap.set("n", "<space>of", require("telescope.builtin").oldfiles, opts)
vim.keymap.set("n", "<space>sb", require("telescope.builtin").current_buffer_fuzzy_find, opts)

vim.keymap.set("n", "<space>gc", ":Telescope git_commits<CR>", opts)
vim.keymap.set("n", "<space>gb", ":Telescope git_branches<CR>", opts)
vim.keymap.set("n", "<space>gs", ":Telescope git_status<CR>", opts)

-- Fugitive
vim.keymap.set("n", "<space>g", ":Git<CR>", opts)
vim.keymap.set("n", "<space>ga", ":Git add %:p<CR><CR>", opts)
vim.keymap.set("n", "<space>gg", ":GBrowse<CR>", opts)
vim.keymap.set("n", "<space>gd", ":Gdiffsplit<CR>", opts)
vim.keymap.set("n", "<space>go", ":Git checkout<Space>", opts)

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
vim.keymap.set("n", "<space>p", "<cmd>lua _RUN_PYTHON()<CR>", opts)
vim.keymap.set("n", "<space>l", ":ToggleTermSendCurrentLine 2<CR>", opts)
vim.keymap.set("v", "<space>l", ":ToggleTermSendVisualLines 2<CR>", opts)

-- DAP
vim.keymap.set("n", "<space>db", require("dap").continue, opts)
vim.keymap.set("n", "<space>dc", require("dap").close, opts)
vim.keymap.set("n", "<space>dq", require("dapui").toggle, opts)
vim.keymap.set("n", "<space>b", require("dap").toggle_breakpoint, opts)
vim.keymap.set("n", "<space>n", require("dap").step_over, opts)
vim.keymap.set("n", "<space>i", require("dap").step_into, opts)
