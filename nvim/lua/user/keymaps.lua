local opts = { noremap = true, silent = true }

local keymap = vim.api.nvim_set_keymap

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

-- Naviagate buffers
vim.keymap.set("n", "<S-l>", ":BufferLineCycleNext<CR>", opts)
vim.keymap.set("n", "<S-h>", ":BufferLineCyclePrev<CR>", opts)
vim.keymap.set("n", "<space>bd", ":bd<CR>", opts)

-- Move line
vim.keymap.set("n", "<C-s>j", ":m .+1<CR>==", { silent = true })
vim.keymap.set("n", "<C-s>k", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<C-s>j", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("i", "<C-s>j", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("i", "<C-s>k", "<Esc>:m .-2<CR>==gi", { silent = true })
vim.keymap.set("v", "<C-s>k", ":m '<-2<CR>gv=gv", { silent = true })

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

vim.keymap.set("n", "<space><space>", ":lua require('telescope.builtin').buffers({ sort_lastused = true })<CR>", opts)
vim.keymap.set("n", "<space>sl", ":Telescope live_grep<CR>", opts)
vim.keymap.set("n", "<space>sg", ":Telescope grep_string<CR>", opts)
vim.keymap.set("n", "<space>h", ":Telescope help_tags<CR>", opts)
vim.keymap.set("n", "<space>of", ":Telescope oldfiles<CR>", opts)
vim.keymap.set("n", "<space>sb", ":Telescope current_buffer_fuzzy_find<CR>", { silent = true })

vim.keymap.set("n", "<space>wo", ":Telescope lsp_document_symbols<CR>", opts)
vim.keymap.set("n", "gr", ":Telescope lsp_references<CR>", opts)
vim.keymap.set("n", "gd", ":Telescope lsp_definitions<CR>", opts)
vim.keymap.set("n", "<space>q", ":Telescope diagnostics bufnr=0<CR>", opts)

vim.keymap.set("n", "<space>gc", ":Telescope git_commits<CR>", { silent = true })
vim.keymap.set("n", "<space>gb", ":Telescope git_branches<CR>", { silent = true })
vim.keymap.set("n", "<space>gs", ":Telescope git_status<CR>", { silent = true })

-- lspsaga
vim.keymap.set("n", "gf", ":Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "K", ":Lspsaga hover_doc<CR>", opts)
vim.keymap.set("i", "<C-k>", ":Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "<space>rn", ":Lspsaga rename<CR>", opts)
vim.keymap.set("n", "<space>ca", ":Lspsaga code_action<CR>", opts)
vim.keymap.set("x", "<space>ca", ":<c-u>Lspsaga range_code_action<CR>", opts)
vim.keymap.set("n", "<space>e", ":Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "gp", ":Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "]d", ":Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "[d", ":Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<CR>", {})
vim.keymap.set("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<CR>", {})

-- Fugitive
vim.keymap.set("n", "<space>g", ":Git<CR>", { silent = true })
vim.keymap.set("n", "<space>ga", ":Git add %:p<CR><CR>", { silent = true })
vim.keymap.set("n", "<space>gg", ":GBrowse<CR>", { silent = true })
vim.keymap.set("n", "<space>gd", ":Gdiffsplit<CR>", { silent = true })
vim.keymap.set("n", "<space>go", ":Git checkout<Space>", { silent = true })

-- NvimTree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Bufferline
vim.keymap.set("n", "[b", ":BufferLineMovePrev<CR>", { silent = true })
vim.keymap.set("n", "]b", ":BufferLineMoveNext<CR>", { silent = true })

-- ToggleTerm
vim.keymap.set("n", "<space>lg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)
