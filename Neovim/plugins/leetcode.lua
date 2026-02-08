return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcarriga/nvim-notify",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    arg = "leetcode.nvim",
    lang = "go", -- Switched to Go based on your database project, but change to "python3" or "java" if preferred
  },
}
