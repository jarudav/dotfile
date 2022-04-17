local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

keymap("n", "<esc><esc>", "<cmd>nohlsearch<CR>", opts)

-- run python
keymap("n", "<leader>R", "%w !python", opts)
keymap("v", "<leader>R", "w !python", opts)

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
keymap("n", "Q", ":bd<CR>", opts)

-- Telescope
keymap("n", "<leader>f", "<cmd>lua require('telescope.builtin').find_files()<CR>", opts)
keymap("n", "<leader><space>", "<cmd>lua require('telescope.builtin').buffers()<CR>", opts)
keymap("n", "<leader>g", "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts)
keymap("n", "<leader>/", "<cmd>lua require('telescope.builtin').help_tags()<CR>", opts)
keymap(
	"n",
	"<leader>s",
	"<cmd>lua require('telescope.builtin').lsp_document_symbols(require('telescope.themes').get_dropdown({}))<CR>",
	opts
)
keymap(
	"n",
	"gr",
	"<cmd>lua require('telescope.builtin').lsp_references(require('telescope.themes').get_dropdown({}))<CR>",
	opts
)
keymap(
	"n",
	"gd",
	"<cmd>lua require('telescope.builtin').lsp_definitions(require('telescope.themes').get_dropdown({}))<CR>",
	opts
)
keymap(
	"n",
	"<leader>q",
	"<cmd>lua require('telescope.builtin').diagnostics(require('telescope.themes').get_dropdown({bufnr=0}))<CR>",
	opts
)
keymap("n", "<leader>fb", "<cmd>Telescope file_browser<CR>", opts)

-- lspsaga
keymap("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
keymap("i", "<C-k>", "<cmd>Lspsaga signature_help<CR>", opts)
keymap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
keymap("x", "<leader>ca", ":<c-u>Lspsaga range_code_action<CR>", opts)
keymap("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
keymap("n", "gp", "<cmd>Lspsaga preview_definition<CR>", opts)
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<CR>", {})
keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<CR>", {})

-- NvimTree
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)
