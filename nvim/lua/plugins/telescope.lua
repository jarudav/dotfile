return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-file-browser.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    cmd = "Telescope",
    version = false,
    keys = {
      {
        "<leader>:",
        function()
          require("telescope.builtin").command_history({ initial_mode = "normal" })
        end,
        desc = "Command History",
      },
      {
        "<leader><space>",
        function()
          require("telescope.builtin").buffers({ initial_mode = "normal" })
        end,
        desc = "Buffers",
      },
      { "<leader>?",  "<cmd>Telescope oldfiles<cr>",    desc = "Recent" },
      {
        "<leader>/",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
            previewer = false,
          }))
        end,
        desc = "Fuzzily search in current buffer",
      },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>",  desc = "status" },
      -- search
      {
        "<leader>sd",
        function()
          require("telescope.builtin").diagnostics(require("telescope.themes").get_dropdown({
            initial_mode = "normal",
          }))
        end,
        desc = "Diagnostics",
      },
      { "<leader>sf", "<cmd>Telescope find_files<cr>",           desc = "Search Files" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>",            desc = "Grep (root dir)" },
      { "<leader>sh", "<cmd>Telescope help_tags<cr>",            desc = "Help Pages" },
      { "<leader>sk", "<cmd>Telescope keymaps<cr>",              desc = "Key Maps" },
      { "<leader>sm", "<cmd>Telescope marks<cr>",                desc = "Jump to Mark" },
      { "<leader>so", "<cmd>Telescope vim_options<cr>",          desc = "Options" },
      { "<leader>sr", "<cmd>Telescope resume<cr>",               desc = "Resume" },
      { "<leader>sw", "<cmd>Telescope grep_string<cr>",          desc = "Word (root dir)" },
      { "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Goto Symbol" },
      { "<leader>e",  "<cmd>Telescope file_browser<cr>",         desc = "File browser" },
      -- lsp
      { "gd",         "<cmd>Telescope lsp_definitions<cr>",      desc = "Goto Definitions" },
      { "gi",         "<cmd>Telescope lsp_implementations<cr>",  desc = "Goto Implementations" },
      { "gt",         "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
      {
        "gr",
        function()
          require("telescope.builtin").lsp_references(require("telescope.themes").get_dropdown({
            initial_mode = "normal",
          }))
        end,
        desc = "Goto References",
      },
    },
    opts = {
      defaults = {
        file_ignore_patterns = { "__pycache__", "%.pyc", "*.DS_Store" },
        mappings = {
          i = {
            ["<C-j>"] = function(...)
              return require("telescope.actions").move_selection_next(...)
            end,
            ["<C-k>"] = function(...)
              return require("telescope.actions").move_selection_previous(...)
            end,
            ["<C-w>"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
            ["w"] = function(...)
              return require("telescope.actions").delete_buffer(...)
            end,
          },
        },
      },
      extensions = {
        fzf = {},
        file_browser = {
          layout_config = { prompt_position = "top" },
          sorting_strategy = "ascending",
          initial_mode = "normal",
          grouped = true,
          hijack_netrw = true,
          mappings = {
            ["i"] = {
              ["<C-d>"] = function(...)
                return require("telescope").extensions.file_browser.actions.remove(...)
              end,
              ["<C-r>"] = function(...)
                return require("telescope").extensions.file_browser.actions.rename(...)
              end,
              ["<C-y>"] = function(...)
                return require("telescope").extensions.file_browser.actions.copy(...)
              end,
            },
            ["n"] = {
              -- ["h"] = function(...)
              -- 	return require("telescope").extensions.file_browser.actions.goto_home_dir(...)
              -- end,
              -- ["p"] = function(...)
              -- 	return require("telescope").extensions.file_browser.actions.goto_parent_dir(...)
              -- end,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("telescope").setup(opts)
      require("telescope").load_extension("file_browser")
      require("telescope").load_extension("fzf")
    end,
  },
}
