return {
  -- wakatime
  { "wakatime/vim-wakatime" },
  -- colorscheme: onedark
  {
    "navarasu/onedark.nvim",
    opts = {
      transparent = true,
      lualine = {
        transparent = true,
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
  -- bufferline
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        numbers = "buffer_id",
        always_show_bufferline = true,
      },
    },
  },
  -- neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    -- visual mode: gc - toggle line comment
  },
  ---@type LazySpec
  {
    "mikavilpas/yazi.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    event = "VeryLazy",
    keys = {
      {
        -- 👇 choose your own keymapping
        "<leader>fy",
        function()
          require("yazi").yazi()
        end,
        { desc = "Open the file manager" },
      },
    },
    ---@type YaziConfig
    opts = {
      open_for_directories = false,
    },
  },
  {
    "vidocqh/data-viewer.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kkharji/sqlite.lua", -- Optional, sqlite support
    },
  },
  {
    "fei6409/log-highlight.nvim",
    config = function()
      require("log-highlight").setup({})
    end,
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua", -- optional
      -- "echasnovski/mini.pick", -- optional
    },
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "m4xshen/hardtime.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("hardtime").setup()
    end,
  },
}
