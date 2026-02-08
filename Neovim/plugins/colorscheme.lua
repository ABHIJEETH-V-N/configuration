return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "moon", -- Sets the variant to Moon
      transparent = true, -- Enables transparency
      styles = {
        sidebars = "transparent", -- Makes Neo-tree/sidebars transparent
        floats = "transparent", -- Makes floating windows transparent
      },
    },
  },
}
