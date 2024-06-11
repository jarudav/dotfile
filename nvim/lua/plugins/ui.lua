return {
  { "MunifTanjim/nui.nvim",        lazy = true },

  -- icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "echasnovski/mini.notify",
    version = "*",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("mini.notify").setup(opts)
    end,
  },

  {
    "echasnovski/mini.animate",
    version = "*",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("mini.animate").setup(opts)
    end,
  },

  {
    "echasnovski/mini.tabline",
    version = "*",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("mini.tabline").setup(opts)
    end,
  },

  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = "BufReadPre",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "Trouble", "lazy", "mason", "notify" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
    config = function(_, opts)
      require("mini.indentscope").setup(opts)
    end,
  },

  {
    "echasnovski/mini.hipatterns",
    version = "*",
    event = "BufReadPre",
    opts = function()
      local hipatterns = require("mini.hipatterns")
      return {
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
          hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
          todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
          note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      }
    end,
    config = function(_, opts)
      require("mini.hipatterns").setup(opts)
    end,
  },

  {
    "echasnovski/mini.cursorword",
    version = "*",
    event = "BufReadPre",
    config = function()
      require("mini.cursorword").setup()
    end,
  },

  {
    "echasnovski/mini.statusline",
    version = "*",
    event = "VeryLazy",
    opts = {},
    config = function(_, opts)
      require("mini.statusline").setup(opts)
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
        inc_rename = true,
      },
    },
    keys = {
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>nl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>nh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>na",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll backward",
        mode = { "i", "n", "s" },
      },
    },
  },
}
