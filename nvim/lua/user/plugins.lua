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
		use("nvim-telescope/telescope-file-browser.nvim")

		--  colorschemes
		use("folke/tokyonight.nvim")

		--  lsp
		use("neovim/nvim-lspconfig")
		use("jose-elias-alvarez/null-ls.nvim")
		use("williamboman/nvim-lsp-installer")
		use("tami5/lspsaga.nvim")

		use({ "ms-jpq/coq_nvim", branch = "coq" })
		use({ "ms-jpq/coq.artifacts", branch = "artifacts" })
		use({ "ms-jpq/coq.thirdparty", branch = "3p" })

		--  cmp
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/nvim-cmp")
		use("saadparwaiz1/cmp_luasnip")
		use("onsails/lspkind-nvim")

		--  snippets
		use("L3MON4D3/LuaSnip")
		use("rafamadriz/friendly-snippets")

		--  treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})

		--  utils
		use("windwp/nvim-autopairs")
		use("numToStr/Comment.nvim")

		--  UI
		use("akinsho/bufferline.nvim")
		use("nvim-lualine/lualine.nvim")
		use("kyazdani42/nvim-web-devicons")

		--  git
		use("lewis6991/gitsigns.nvim")
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
