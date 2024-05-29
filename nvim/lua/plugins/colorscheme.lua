return {
  {
    "svrana/neosolarized.nvim",
    lazy = false,
    priority = 1000,
    opts = { comment_italics = true },
    dependencies = { "tjdevries/colorbuddy.nvim" },
    config = function()
      vim.cmd("colorscheme neosolarized")
    end,
  },

  { "norcalli/nvim-colorizer.lua", opts = { "*" } },
}
