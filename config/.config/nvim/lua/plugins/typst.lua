return {
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = '1.*',
    opts = {
      host = '127.0.0.1'
    },
    keys = {
      {
        "<leader>tp",
        ft = "typst",
        "<cmd>TypstPreviewToggle<cr>",
        desc = "Toggle Typst Preview",
      },
    }
  },
}
