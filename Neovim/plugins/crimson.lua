return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = true, -- Blends perfectly with your blurred mountain wallpaper
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
      on_highlights = function(hl, c)
        local crimson = "#DC143C" -- Your Crimson Red
        local blood_dark = "#440000"

        -- UI Visibility (High Contrast for blurred backgrounds)
        hl.CursorLineNr = { fg = crimson, bold = true }
        hl.LineNr = { fg = "#4d4d6e" }
        hl.Visual = { bg = blood_dark }

        -- Crimson Syntax Accents
        hl.Function = { fg = crimson, bold = true }
        hl.Statement = { fg = crimson }
        hl.Directory = { fg = crimson }

        -- Border & Floating Windows (Stealth Look)
        hl.FloatBorder = { fg = crimson, bg = "none" }
        hl.TelescopeBorder = { fg = crimson, bg = "none" }
        hl.TelescopePromptTitle = { fg = crimson, bold = true }
        hl.TelescopePromptPrefix = { fg = crimson }

        -- LazyVim Specific UI (Dashboard/Noice)
        hl.NoiceFormatProgressDone = { bg = crimson }
        hl.LazyProgressDone = { fg = crimson }
      end,
    },
  },

  -- 2. Matching Lualine (Status bar)
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      local crimson = "#DC143C"
      opts.options.theme = "tokyonight"
      -- Force the 'A' section (Mode) to be Crimson
      opts.sections.lualine_a = {
        { "mode", color = { fg = "#ffffff", bg = crimson, gui = "bold" } },
      }
      -- Force the 'C' section (Filename) to use Crimson text
      opts.sections.lualine_c = {
        { "filename", color = { fg = crimson, gui = "bold" } },
      }
    end,
  },
}
