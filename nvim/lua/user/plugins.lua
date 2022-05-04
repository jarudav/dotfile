local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local use = require("packer").use
packer.startup({
	function()
		use("wbthomason/packer.nvim")

		use("nvim-lua/popup.nvim")
		use("nvim-lua/plenary.nvim")

		--  file explorer
		use("kyazdani42/nvim-tree.lua")

		--  terminal
		use("akinsho/toggleterm.nvim")

		--  telescope
		use("nvim-telescope/telescope.nvim")
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		--  colorschemes
		use("folke/tokyonight.nvim")

		--  lsp
		use("neovim/nvim-lspconfig")
		use("jose-elias-alvarez/null-ls.nvim")
		use("williamboman/nvim-lsp-installer")
		use("j-hui/fidget.nvim")

		--  cmp
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/nvim-cmp")
		use("onsails/lspkind-nvim")

		--  snippets
		use("saadparwaiz1/cmp_luasnip")
		use("L3MON4D3/LuaSnip")
		use("rafamadriz/friendly-snippets")

		--  treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})
		use("nvim-treesitter/nvim-treesitter-textobjects")

		--  utils
		use("windwp/nvim-autopairs")
		use("numToStr/Comment.nvim")

		--  UI
		use("akinsho/bufferline.nvim")
		use("nvim-lualine/lualine.nvim")
		use("kyazdani42/nvim-web-devicons")
		use("lukas-reineke/indent-blankline.nvim")
		use("RRethy/vim-illuminate")
		use("karb94/neoscroll.nvim")

		--  git
		use("tpope/vim-fugitive")
		use("tpope/vim-rhubarb")
		use("lewis6991/gitsigns.nvim")

		-- Debug Adapter Protocol
		use("mfussenegger/nvim-dap")
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
