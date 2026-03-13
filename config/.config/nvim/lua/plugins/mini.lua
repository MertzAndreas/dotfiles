return {
  {
    'nvim-mini/mini.ai',
    event = "VeryLazy",
    version = false,
    opts = {}
  },
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
    config = function(_, opts)
      local pairs = require("mini.pairs")
      pairs.setup(opts)

      local map_typst = function(buf_id)
        pairs.map_buf(buf_id, "i", "$", {
          action = "closeopen",
          pair = "$$",
          neigh_pattern = "[^\\].",
          register = { cr = false },
        })
      end

      if vim.bo.filetype == "typst" then
        map_typst(0)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "typst",
        callback = function(args)
          map_typst(args.buf)
        end,
      })
    end,
  },

  {
    "nvim-mini/mini.surround",
    event = "VeryLazy",
    version = false,
    opts = {
      mappings = {
        add = "gsa",            -- Add surrounding in Normal and Visual modes
        delete = "gsd",         -- Delete surrounding
        find = "gsf",           -- Find surrounding (to the right)
        find_left = "gsF",      -- Find surrounding (to the left)
        highlight = "gsh",      -- Highlight surrounding
        replace = "gsr",        -- Replace surrounding
        update_n_lines = "gsn", -- Update `n_lines`
      },
      custom_surroundings = {
        ["$"] = {
          input = { "%$().-()%$" },
          output = { left = "$", right = "$" },
        },
      },
    },
  },
  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {
      file = {
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
    },
    init = function()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
