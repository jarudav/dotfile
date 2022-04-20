local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("n", "<esc><esc>", "<cmd>nohlsearch<CR>", opts)

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

-- Naviagate buffers
keymap("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<space>bd", ":bd<CR>", opts)

-- Move line
vim.keymap.set("n", "<C-l>j", ":m .+1<CR>==")
vim.keymap.set("n", "<C-l>k", ":m .-2<CR>==")
vim.keymap.set("v", "<C-l>j", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<C-l>j", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("i", "<C-l>k", "<Esc>:m .-2<CR>==gi")
vim.keymap.set("v", "<C-l>k", ":m '<-2<CR>gv=gv")

-- annoy keybind
vim.keymap.set("", "J", "<Nop>", { silent = true })

-- Telescope
function TelescopeFiles()
	local telescope_opts = { previewer = false }
	local ok = pcall(require("telescope.builtin").git_files, telescope_opts)
	if not ok then
		require("telescope.builtin").find_files(telescope_opts)
	end
end
vim.keymap.set("n", "<space>f", TelescopeFiles)

vim.keymap.set("n", "<space>sb", function()
	require("telescope.builtin").current_buffer_fuzzy_find()
end)
keymap("n", "<space><space>", "<cmd>lua require('telescope.builtin').buffers({ sort_lastused = true })<CR>", opts)
keymap("n", "<space>sl", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<space>sg", "<cmd>lua require('telescope.builtin').grep_string()<CR>", opts)
keymap("n", "<space>h", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)
keymap("n", "<space>of", "<cmd>lua require('telescope.builtin').oldfiles()<CR>", opts)

keymap("n", "<space>wo", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", opts)
keymap("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
keymap("n", "<space>q", "<cmd>lua require('telescope.builtin').diagnostics()<CR>", opts)

vim.keymap.set("n", "<space>gc", function()
	require("telescope.builtin").git_commits()
end)
vim.keymap.set("n", "<space>gb", function()
	require("telescope.builtin").git_branches()
end)
vim.keymap.set("n", "<space>gs", function()
	require("telescope.builtin").git_status()
end)

keymap("n", "<space>fb", "<cmd>Telescope file_browser<CR>", opts)

-- lspsaga
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("i", "<C-k>", "<cmd>Lspsaga signature_help<CR>", opts)
keymap("n", "<space>rn", "<cmd>Lspsaga rename<CR>", opts)
keymap("n", "<space>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap("x", "<space>ca", ":<c-u>Lspsaga range_code_action<CR>", opts)
keymap("n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "gp", "<cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<CR>", {})
keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<CR>", {})

-- Fugitive
vim.keymap.set("n", "<space>g", ":Git<CR>", { silent = true })
vim.keymap.set("n", "<space>ga", ":Git add %:p<CR><CR>", { silent = true })
vim.keymap.set("n", "<space>gg", ":GBrowse<CR>", { silent = true })
vim.keymap.set("n", "<space>gd", ":Gdiffsplit<CR>", { silent = true })
vim.keymap.set("n", "<space>go", ":Git checkout<Space>", { silent = true })

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
