return {
    {
        "sindrets/diffview.nvim",
        event = "VeryLazy",
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
            {
                "<leader>gc",
                function()
                    require("snacks").picker.git_log({
                        confirm = function(picker, item)
                            picker:close()
                            if item then
                                require("diffview").open(item.commit .. "^!")
                            end
                        end,
                    })
                end,
                desc = "Pick commit to diff",
            },
        },
    },
}
