vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.completeopt:append("noselect")
opt.conceallevel = 3 -- Hide * markup for bold and italic
opt.confirm = true -- Confirm to save changes before exiting modified buffer
-- opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.guicursor = "a:blinkon0"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 3
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "" -- Disable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
-- opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = true -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.smoothscroll = true
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeout = true
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap

vim.cmd([[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]])

local function augroup(name)
	return vim.api.nvim_create_augroup("My" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = augroup("hightlight_yank"),
	pattern = "*",
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	group = augroup("auto_create_dir"),
	callback = function(event)
		local file = vim.loop.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"help",
		"lspinfo",
		"man",
		"qf",
		"startuptime",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	command = "set nopaste",
})

local keymap_opts = { noremap = true, silent = true }
local keymap = vim.keymap.set

keymap({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", keymap_opts)

keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Navigate window
keymap("n", "<C-h>", "<C-w>h", keymap_opts)
keymap("n", "<C-j>", "<C-w>j", keymap_opts)
keymap("n", "<C-k>", "<C-w>k", keymap_opts)
keymap("n", "<C-l>", "<C-w>l", keymap_opts)

-- Resize  window
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", keymap_opts)
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", keymap_opts)
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", keymap_opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", keymap_opts)

-- Move line
keymap("n", "<C-s>j", "<cmd>m .+1<CR>==", keymap_opts)
keymap("n", "<C-s>k", "<cmd>m .-2<CR>==", keymap_opts)
keymap("i", "<C-s>j", "<esc><cmd>m .+1<CR>==gi", keymap_opts)
keymap("i", "<C-s>k", "<esc><cmd>m .-2<CR>==gi", keymap_opts)
keymap("v", "<C-s>j", "<cmd>m '>+1<CR>gv=gv", keymap_opts)
keymap("v", "<C-s>k", "<cmd>m '<-2<CR>gv=gv", keymap_opts)

-- annoy keybind
keymap("", "J", "<Nop>", keymap_opts)
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Plugins
vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/nvim-mini/mini.diff" },
})

require("vim._core.ui2").enable({})

-- LSP
local diagnostics = {
	underline = true,
	update_in_insert = false,
	virtual_text = { current_line = true, spacing = 4, source = "if_many", prefix = "●" },
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ",
			[vim.diagnostic.severity.WARN] = " ",
			[vim.diagnostic.severity.HINT] = " ",
			[vim.diagnostic.severity.INFO] = " ",
		},
	},
}
local diagnostic_float = {
	focusable = false,
	close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
	border = "rounded",
	source = "always",
	prefix = " ",
	scope = "line",
}

for severity, icon in pairs(diagnostics.signs.text) do
	local name = vim.diagnostic.severity[severity]:lower():gsub("^%l", string.upper)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
vim.diagnostic.config(diagnostics)

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Lsp Actions",
	callback = function(args)
		local bufnr = args.buf
		local client = vim.lsp.get_client_by_id(args.data.client_id)

		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
		end

		if client:supports_method("textDocument/documentColor") then
			vim.lsp.document_color.enable(true, { bufnr = args.buf })
		end

		if client.server_capabilities.documentHighlightProvider then
			vim.api.nvim_create_augroup("lsp_document_highlight", {
				clear = false,
			})
			vim.api.nvim_clear_autocmds({
				buffer = bufnr,
				group = "lsp_document_highlight",
			})
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group = "lsp_document_highlight",
				buffer = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group = "lsp_document_highlight",
				buffer = bufnr,
				callback = vim.lsp.buf.clear_references,
			})
		end

		keymap("n", "<space>e", function()
			vim.diagnostic.open_float(nil, diagnostic_float)
		end)

		keymap("i", "<C-k>", function()
			vim.lsp.buf.signature_help()
		end)
	end,
})

local servers = {
	ty = {
		ty = {
			experimental = {
				rename = true,
			},
		},
	},
	ruff = {},
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			completion = { callSnippet = "Replace" },
			telemetry = { enable = false },
		},
	},
}

for lsp, server_opt in pairs(servers) do
	vim.lsp.enable(lsp)
	vim.lsp.config(lsp, {
		settings = server_opt,
	})
end

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "ruff_format", "ruff_organize_imports" },
		javascript = { "prettier" },
		css = { "prettier" },
		json = { "prettier" },
		html = { "prettier" },
		yaml = { "prettier" },
	},
	default_format_opts = {
		lsp_format = "fallback",
	},
	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

require("fzf-lua").setup({
	"max-perf",
	file_ignore_patterns = {
		"%.DS_Store$",
		"tmp/",
		"__pycache__",
		"%.docx",
		"%.geojson",
		"%.grib",
		"%.h5",
		"%.hdf5",
		"%.ipynb",
		"%.jpg",
		"%.nc",
		"%.pdf",
		"%.png",
		"%.pt",
		"%.pth",
		"%.pkl",
		"%.xlxs",
		"%.zip",
		"%.shp",
		"%.shx",
		"%.shp.xml",
		"%.cpg",
		"%.dbf",
		"%.prj",
		"%.sbn",
		"%.sbx",
		"%.tif",
		"%.tiff",
	},
	winopts = {
		preview = { default = "bat_native" },
	},
	keymap = {
		builtin = {
			["<c-f>"] = "preview-page-down",
			["<c-b>"] = "preview-page-up",
		},
		fzf = {
			["ctrl-q"] = "select-all+accept",
			["ctrl-d"] = "half-page-down",
			["ctrl-u"] = "half-page-up",
			["ctrl-f"] = "preview-page-down",
			["ctrl-b"] = "preview-page-up",
		},
	},
})

keymap("n", "<leader><leader>", function()
	require("fzf-lua").buffers({ sort_mru = true, sort_lastused = true })
end, { desc = "Fzf Switch Buffer" })
keymap("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Fzf Files" })
keymap("n", "<leader>fF", function()
	require("fzf-lua").files({ cwd = "%:p:h" })
end, { desc = "Fzf Files (cwd)" })
keymap("n", "<leader>fg", function()
	require("fzf-lua").git_files()
end, { desc = "Fzf Files (git-files)" })
-- git
keymap("n", "<leader>gc", function()
	require("fzf-lua").git_commits()
end, { desc = "Fzf Commits" })
keymap("n", "<leader>gs", function()
	require("fzf-lua").git_status()
end, { desc = "Fzf Status" })
-- search
keymap("n", "<leader>sg", function()
	require("fzf-lua").live_grep_native()
end, { desc = "Fzf Live Grep" })
keymap("n", "<leader>sr", function()
	require("fzf-lua").live_grep({ resume = true })
end, { desc = "Fzf Live Grep Continue Last Search" })
keymap("n", "<leader>sq", function()
	require("fzf-lua").lgrep_quickfix()
end, { desc = "Fzf the quickfix list" })
keymap("n", "<leader>sl", function()
	require("fzf-lua").lgrep_loclist()
end, { desc = "Fzf the location list" })
keymap("n", "<leader>sw", function()
	require("fzf-lua").grep_cword()
end, { desc = "Fzf Grep word" })
keymap("n", "<leader>/", function()
	require("fzf-lua").lgrep_curbuf()
end, { desc = "Fzf Live Grep Current Buffer" })
keymap("n", "<leader>sj", function()
	require("fzf-lua").jumps()
end, { desc = "Fzf Jumps List" })
keymap("n", "<leader>sk", function()
	require("fzf-lua").keymaps()
end, { desc = "Fzf Key Maps" })
keymap("n", "<leader>sb", function()
	require("fzf-lua").builtin()
end, { desc = "Fzf Files (git-files)" })
keymap("n", "<leader>sh", function()
	require("fzf-lua").search_history()
end, { desc = "Fzf Search History" })
keymap("n", "<leader>sc", function()
	require("fzf-lua").command_history()
end, { desc = "Fzf Command History" })
-- lsp
keymap("n", "gd", function()
	require("fzf-lua").lsp_definitions({ jump1 = true, ignore_current_line = true })
end, { desc = "Fzf Goto Definition" })
keymap("n", "gr", function()
	require("fzf-lua").lsp_references({
		jump1 = true,
		ignore_current_line = true,
		includeDeclaration = false,
	})
end, { desc = "Fzf Goto Definition" })
keymap("n", "<leader>d", function()
	require("fzf-lua").diagnostics_document()
end, { desc = "Fzf Document Diagnostics" })
keymap("n", "<leader>D", function()
	require("fzf-lua").diagnostics_workspace()
end, { desc = "Fzf Workspace Diagnostics" })
keymap("n", "<leader>ss", function()
	require("fzf-lua").lsp_document_symbols({})
end, { desc = "Goto Symbol" })
keymap("n", "<leader>sS", function()
	require("fzf-lua").lsp_live_workspace_symbols({})
end, { desc = "Goto Symbol (Workspace)" })

require("tokyonight").setup({ transparent = true })
vim.cmd.colorscheme("tokyonight")

require("which-key").setup()

require("nvim-treesitter").setup({
	sync_install = false,
	auto_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	context_commentstring = { enable = true, enable_autocmd = false },
	ensure_installed = {
		"bash",
		"css",
		"json",
		"html",
		"nu",
		"python",
		"query",
		"regex",
		"sql",
		"xml",
		"yaml",
	},
	ignore_install = {},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<CR>",
			node_incremental = "<CR>",
			scope_incremental = false,
			node_decremental = "<BS>",
		},
	},
})

require("treesitter-context").setup({ max_lines = 1 })

require("mini.surround").setup()
require("mini.diff").setup({ view = { style = "sign" } })
