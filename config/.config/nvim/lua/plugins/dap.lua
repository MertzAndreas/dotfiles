return {
    {
        "mfussenegger/nvim-dap",
        event = "VeryLazy",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            require("mason-nvim-dap").setup({
                ensure_installed = { "python", "codelldb" },
                automatic_installation = true,
                handlers = {},
            })

            require("nvim-dap-virtual-text").setup()

            dapui.setup()

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Python adapter
            dap.adapters.python = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
                args = { "-m", "debugpy.adapter" },
            }

            -- Python configuration
            dap.configurations.python = {
                {
                    type = "python",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    pythonPath = function()
                        local venv = vim.fn.getcwd() .. "/venv/bin/python"
                        if vim.fn.executable(venv) == 1 then
                            return venv
                        end
                        return "/usr/bin/python3"
                    end,
                },
            }

            local netcoredbg_adapter = {
                type = "executable",
                command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg",
                args = { "--interpreter=vscode" },
            }

            dap.adapters.netcoredbg = netcoredbg_adapter
            dap.adapters.coreclr = netcoredbg_adapter

            dap.configurations.cs = {
                {
                    type = "coreclr",
                    name = "Launch - netcoredbg",
                    request = "launch",
                    program = function()
                        return require("config.nvim-dap-dotnet").build_dll_path()
                    end,
                },
                {
                    type = "coreclr",
                    name = "Test - netcoredbg",
                    request = "attach",
                    processId = function()
                        -- Pick which test project to run
                        local test_projects = vim.fn.glob(vim.fn.getcwd() .. "/Tests/*/*.csproj", false, true)
                        local choices = {}
                        for _, p in ipairs(test_projects) do
                            table.insert(choices, vim.fn.fnamemodify(p, ":h"))
                        end

                        vim.ui.select(choices, { prompt = "Select test project:" }, function(choice)
                            if choice then
                                -- Launch dotnet test in background
                                vim.fn.jobstart("VSTEST_HOST_DEBUG=1 dotnet test " .. choice, {
                                    on_stdout = function(_, data)
                                        for _, line in ipairs(data) do
                                            print(line)
                                        end
                                    end,
                                    detach = false,
                                })
                            end
                        end)

                        -- Give it a moment to spawn then pick the process
                        vim.defer_fn(function() end, 3000)
                        return require("dap.utils").pick_process({ filter = "dotnet" })
                    end,
                },
            }
        end,
        keys = {
            {
                "<leader>db",
                function()
                    require("dap").toggle_breakpoint()
                end,
                desc = "Toggle Breakpoint",
            },
            {
                "<leader>dc",
                function()
                    require("dap").continue()
                end,
                desc = "Run/Continue",
            },
            {
                "<leader>da",
                function()
                    require("dap").continue({ before = get_args })
                end,
                desc = "Run with Args",
            },
            {
                "<leader>dC",
                function()
                    require("dap").run_to_cursor()
                end,
                desc = "Run to Cursor",
            },
            {
                "<leader>dg",
                function()
                    require("dap").goto_()
                end,
                desc = "Go to Line (No Execute)",
            },
            {
                "<leader>di",
                function()
                    require("dap").step_into()
                end,
                desc = "Step Into",
            },
            {
                "<leader>dj",
                function()
                    require("dap").down()
                end,
                desc = "Down",
            },
            {
                "<leader>dk",
                function()
                    require("dap").up()
                end,
                desc = "Up",
            },
            {
                "<leader>dl",
                function()
                    require("dap").run_last()
                end,
                desc = "Run Last",
            },
            {
                "<leader>do",
                function()
                    require("dap").step_out()
                end,
                desc = "Step Out",
            },
            {
                "<leader>dO",
                function()
                    require("dap").step_over()
                end,
                desc = "Step Over",
            },
            {
                "<leader>dP",
                function()
                    require("dap").pause()
                end,
                desc = "Pause",
            },
            {
                "<leader>dr",
                function()
                    require("dap").repl.toggle()
                end,
                desc = "Toggle REPL",
            },
            {
                "<leader>ds",
                function()
                    require("dap").session()
                end,
                desc = "Session",
            },
            {
                "<leader>dt",
                function()
                    require("dap").terminate()
                end,
                desc = "Terminate",
            },
            {
                "<leader>dw",
                function()
                    require("dap.ui.widgets").hover()
                end,
                desc = "Widgets",
            },
            {
                "<leader>du",
                function()
                    require("dapui").toggle()
                end,
                desc = "Toggle DAP UI",
            },
            {
                "<leader>de",
                function()
                    require("dapui").eval()
                end,
                desc = "Eval Expression",
                mode = { "n", "v" },
            },
        },
    },
}
