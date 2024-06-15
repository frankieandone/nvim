return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },
    --
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                --formatters
                "stylua",
                "prettierd",
                "ktfmt", --kotlin
                "beautyzsh", --(bash, csh, ksh, sh, zsh)
                --linters
                "cfn-lint", --yaml, json, cloudformation
                "vacuum", --openapi
                --lsp
                "ast-grep", --polyglot (c, c++, rust, go, java, python, c#, js, jsx, ts, html, css, kotlin, dart, lua)
                "dockerfile-language-server",
                "docker-compose-language-server",
                "gradle-language-server",
                "yaml-language-server",
                "json-lsp",
            },
        },
    },
    --
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "markdown_inline",
                "javascript",
                "yaml",
                "json",
                "toml",
                "properties",
                "xml",
                "groovy",
                "kotlin",
            },
        },
    },
}
