local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("Packer is not installed")
	return
end

local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

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

		--  telescope
		use({
			"nvim-telescope/telescope.nvim",
			tag = "0.1.0",
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		--  file explorer
		use({
			"nvim-tree/nvim-tree.lua",
			requires = {
				"nvim-tree/nvim-web-devicons", -- optional, for file icons
			},
			tag = "nightly", -- optional, updated every week. (see issue #1193)
		})

		--  lsp
		use("neovim/nvim-lspconfig")
		use("williamboman/mason.nvim")
		use("williamboman/mason-lspconfig.nvim")
		use("jose-elias-alvarez/null-ls.nvim")
		use("j-hui/fidget.nvim")
		use("glepnir/lspsaga.nvim")

		--  cmp
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/nvim-cmp")
		use("onsails/lspkind-nvim")

		--  snippets
		use("L3MON4D3/LuaSnip")

		--  treesitter
		use({
			"nvim-treesitter/nvim-treesitter",
			run = ":TSUpdate",
		})
		use("nvim-treesitter/nvim-treesitter-textobjects")

		--  terminal
		use({
			"akinsho/toggleterm.nvim",
			tag = "*",
			config = function()
				require("toggleterm").setup()
			end,
		})

		--  colorschemes
		use({
			"svrana/neosolarized.nvim",
			requires = { "tjdevries/colorbuddy.nvim" },
		})

		--  utils
		use("windwp/nvim-autopairs")
		use("numToStr/Comment.nvim")
		use("tpope/vim-surround")

		--  UI
		use("akinsho/bufferline.nvim")
		use("nvim-lualine/lualine.nvim")
		use("lukas-reineke/indent-blankline.nvim")
		use("RRethy/vim-illuminate")
		use("karb94/neoscroll.nvim")
		use("norcalli/nvim-colorizer.lua")

		--  git
		use("lewis6991/gitsigns.nvim")

		if packer_bootstrap then
			require("packer").sync()
		end
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})
