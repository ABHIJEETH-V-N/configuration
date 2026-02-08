return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
 /$$   /$$ /$$     /$$ /$$$$$$$  /$$$$$$$$ /$$$$$$$ 
| $$  | $$|  $$   /$$/| $$__  $$| $$_____/| $$__  $$
| $$  | $$ \  $$ /$$/ | $$  \ $$| $$      | $$  \ $$
| $$$$$$$$  \  $$$$/  | $$$$$$$/| $$$$$   | $$$$$$$/
| $$__  $$   \  $$/   | $$____/ | $$__/   | $$__  $$
| $$  | $$    | $$    | $$      | $$      | $$  \ $$
| $$  | $$    | $$    | $$      | $$$$$$$$| $$  | $$
|__/  |__/    |__/    |__/      |________/|__/  |__/]],
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      -- This function applies your Crimson Stealth theme
      local function apply_crimson()
        local crimson = "#DC143C"
        vim.api.nvim_set_hl(0, "SnacksDashboardHeader", { fg = crimson, bold = true })
        vim.api.nvim_set_hl(0, "SnacksDashboardKey", { fg = crimson })
        vim.api.nvim_set_hl(0, "SnacksDashboardDesc", { fg = "#C0C0C0" })
      end

      -- Apply it immediately
      apply_crimson()

      -- Re-apply it whenever the colorscheme changes (fixes the "still blue" issue)
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = apply_crimson,
      })
    end,
  },
}
