return {
  {
    "folke/tokyonight.nvim",
    event = "VeryLazy",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    event = "VeryLazy",
  },
  {
    "kepano/flexoki-neovim",
    event = "VeryLazy",
  },

  {
    "ribru17/bamboo.nvim",
    opts = {
      transparent = true,
      toggle_style_list = { "multiplex" },
    },
    event = "VeryLazy",
  },
  {
    "tahayvr/matteblack.nvim",
    event = "VeryLazy",
  },
  {
    "rose-pine/neovim",
    event = "VeryLazy",
    name = "rose-pine"
  },
  {
    "neanias/everforest-nvim",
    event = "VeryLazy",
    config = function()
      require("everforest").setup({
        background = "medium",
        coloursroverride = function(palette)
          palette.bg0 = "#272e33"
          palette.bg1 = "#272e33"
          palette.bg2 = "#272e33"
        end,
        on_highlights = function(hl, palette)
          local bg = "#272e33"
          hl.Normal = { fg = palette.fg0, bg = bg }
          hl.NormalNC = { fg = palette.fg0, bg = bg }
          hl.SignColumn = { fg = palette.fg0, bg = bg }
          hl.VertSplit = { fg = palette.bg2, bg = bg }
        end,
      })
    end,
  },
  { "EdenEast/nightfox.nvim",     event = "VeryLazy" },
  { "gthelding/monokai-pro.nvim", event = "VeryLazy" },
  { "ellisonleao/gruvbox.nvim",   event = "VeryLazy" },
  { "rebelot/kanagawa.nvim",      event = "VeryLazy" },
}
