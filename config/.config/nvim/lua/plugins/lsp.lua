return {
    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "saghen/blink.cmp",
            {
                "williamboman/mason.nvim",
                config = true,
                opts = {
                    registries = {
                        "github:mason-org/mason-registry",
                        "github:Crashdummyy/mason-registry",
                    },
                },
            },
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            local mason_lspconfig = require("mason-lspconfig")
            local blink = require("blink.cmp")

            vim.lsp.config("*", {
                root_markers = { ".git" },
                capabilities = blink.get_lsp_capabilities(),
            })

            require("mason").setup({
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            })
            mason_lspconfig.setup({
                ensure_installed = {
                    "lua_ls",
                    "hls",
                    "clangd",
                    "basedpyright",
                    "bash-language-server",
                    "gopls",
                    "docker_language_server",
                    "jsonls",
                    "vtsls",
                    "tinymist",
                },
                automatic_enable = true,
            })

            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    local bufnr = ev.buf
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)

                    local map = function(keys, func, desc)
                        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
                    end

                    map("K", function()
                        vim.lsp.buf.hover({ border = "single" })
                    end, "Hover")

                    map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
                    map("<leader>rn", vim.lsp.buf.rename, "Rename")

                    if client and client.server_capabilities.inlayHintProvider then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
                        end, "Toggle Inlay Hints")
                    end
                end,
            })
        end,
    },

    -- Completion
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets", "xzbdmw/colorful-menu.nvim" },
        event = { "BufReadPre", "BufNewFile" },
        version = "1.*",
        build = "cargo +nightly build --release",

        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            signature = {
                enabled = true,
                trigger = {
                    show_on_insert_on_trigger_character = true,
                    show_on_accept = true,
                    show_on_trigger_character = true,
                },
                window = {
                    show_documentation = false,
                    border = "single",
                },
            },
            appearance = {
                nerd_font_variant = "mono",
                kind_icons = {
                    Text = "󰉿",
                    Method = "󰊕",
                    Function = "󰊕",
                    Constructor = "󰒓",
                    Field = "󰜢",
                    Variable = "󰆦",
                    Property = "󰖷",
                    Class = "󱡠",
                    Interface = "󱡠",
                    Struct = "󱡠",
                    Module = "󰅩",
                    Unit = "󰪚",
                    Value = "󰦨",
                    Enum = "󰦨",
                    EnumMember = "󰦨",
                    Keyword = "󰻾",
                    Constant = "󰏿",
                    Snippet = "󱄽",
                    Color = "󰏘",
                    File = "󰈔",
                    Reference = "󰬲",
                    Folder = "󰉋",
                    Event = "󱐋",
                    Operator = "󰪚",
                    TypeParameter = "󰬛",
                },
            },
            completion = {
                documentation = { auto_show = true },
                menu = {
                    border = "single",
                    draw = {
                        components = {
                            label = {
                                text = function(ctx)
                                    return require("colorful-menu").blink_components_text(ctx)
                                end,
                                highlight = function(ctx)
                                    return require("colorful-menu").blink_components_highlight(ctx)
                                end,
                            },
                        },
                        columns = {
                            { "kind_icon" },
                            { "label", "label_description", gap = 1 },
                            { "kind" },
                        },
                    },
                },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                per_filetype = {
                    sql = { "dadbod", "buffer" },
                },
                providers = {
                    dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
                },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
        },
        opts_extend = { "sources.default" },
    },

    -- Helps resolve global variables
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "snacks.nvim", words = { "Snacks" } },
            },
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate",
        event = "VeryLazy",
        opts = {
            install_dir = vim.fn.stdpath("data") .. "/site",
            ensure_installed = { "python", "lua", "vim", "vimdoc", "query", "markdown" },
        },
        config = function(_, opts)
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("TS_AutoInstall", { clear = true }),
                callback = function(args)
                    local ts = require("nvim-treesitter")
                    ts.setup(opts)
                    ts.install(opts.ensure_installed)

                    if pcall(vim.treesitter.start, args.buf) then
                        return
                    end

                    local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
                        or vim.bo[args.buf].filetype

                    if not vim.tbl_contains(ts.get_available(), lang) then
                        return
                    end

                    Snacks.notify.info("Installing Treesitter parser for " .. lang)

                    ts.install({ lang }):await(function()
                        vim.schedule(function()
                            if pcall(vim.treesitter.start, args.buf) then
                                Snacks.notify.info("Treesitter active for " .. lang)
                            else
                                Snacks.notify.warn("Install finished, but failed to load " .. lang)
                            end
                        end)
                    end)
                end,
            })
        end,
    },

    -- Auto-formatting
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        opts = {
            documentation = { auto_show = true, auto_show_delay_ms = 500 },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { "prettierd", "prettier", stop_after_first = true },
                typescript = { "prettierd", "prettier", stop_after_first = true },
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },
}
