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
            {
                "<leader>co",
                function()
                    require("diffview.actions").conflict_choose("ours")
                end,
                desc = "Choose the OURS version of a conflict",
            },
            {
                "<leader>ct",
                function()
                    require("diffview.actions").conflict_choose("theirs")
                end,
                desc = "Choose the THEIRS version of a conflict",
            },
            {
                "<leader>cb",
                function()
                    require("diffview.actions").conflict_choose("base")
                end,
                desc = "Choose the BASE version of a conflict",
            },
            {
                "<leader>cA",
                function()
                    require("diffview.actions").conflict_choose("all")
                end,
                desc = "Choose all the versions of a conflict",
            },
            {
                "dx",
                function()
                    require("diffview.actions").conflict_choose("none")
                end,
                desc = "Delete the conflict region",
            },
            {
                "<leader>b",
                function()
                    require("diffview.actions").toggle_files()
                end,
                desc = "Toggle the file panel",
            },
        },
    },
}
