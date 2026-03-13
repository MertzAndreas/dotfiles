return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim", "folke/snacks.nvim" },
    keys = function()
      local harpoon = require("harpoon")
      local list = harpoon:list()

      local function harpoon_picker()
        Snacks.picker.pick({
          title = "Harpoon Marks",
          format = "file",

          finder = function()
            local items = {}
            ---@param h_item HarpoonItem
            for _, h_item in ipairs(list.items) do
              table.insert(items, {
                text = h_item.value,
                file = h_item.value,
                harpoon_item = h_item,
              })
            end
            return items
          end,

          actions = {
            ---@param picker snacks.Picker
            ---@param item snacks.picker.Item
            remove_mark = function(picker, item)
              local to_remove = picker:selected()

              if #to_remove == 0 then
                to_remove = { item }
              end

              for _, sel in ipairs(to_remove) do
                list:remove(sel.harpoon_item)
              end
              picker:find()
            end,
          },

          win = {
            input = {
              keys = {
                ["<c-d>"] = { "remove_mark", mode = { "n", "i" } },
              },
            },
          },
        })
      end

      local keys = {
        {
          "<leader>hh",
          function()
            list:add()
          end,
          desc = "Harpoon File",
        },
        {
          "<leader>hH",
          harpoon_picker,
          desc = "Harpoon Quick Menu",
        },
      }

      for i = 1, 9 do
        table.insert(keys, {
          "<leader>" .. i,
          function()
            list:select(i)
          end,
          desc = "which_key_ignore"

        })
      end

      return keys
    end,
  },
}
