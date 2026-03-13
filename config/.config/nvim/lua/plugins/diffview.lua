return {
  {
    "sindrets/diffview.nvim",
    opts = {},
    keys = {
      {
        "<leader>gd",
        function()
          local lib = require("diffview.lib")
          local view = lib.get_current_view()
          if view then
            vim.cmd("DiffviewClose")
          else
            require("diffview").open({})
          end
        end,
        desc = "Toggle DiffView",
      },
    },
  }
}
