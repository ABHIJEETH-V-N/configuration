return {
  -- Core Quarto plugin for .ipynb and .qmd files
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lspFeatures = {
        languages = { "python" },
        chunks = "all",
        diagnostics = { enabled = true },
        completion = { enabled = true },
      },
    },
  },

  -- Molten for interactive code execution (The "Kernel")
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version 1.0.0 for stability
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },

  -- Image rendering (requires a compatible terminal like Kitty or WezTerm)
  {
    "3rd/image.nvim",
    enabled = false,
    opts = {
      backend = "kitty", -- or "ueberzug" if on Linux/X11
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
    },
  },
}
