local nvchad_lsp_config = require "nvchad.configs.lspconfig"
local default_lsp_config = require "lspconfig"

-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local lsp_services = {
    bashls = {},
    kotlin_language_server = {},
    biome = {},
    rust_analyzer = {},
    lua_ls = {},
}

-- Function to enable inlay hints if supported by the LSP server
local function enable_inlay_hints(client)
    local inlay_hint_key = "Editor.inlayHints.enabled"
    if client.server_capabilities[inlay_hint_key] then
        client.server_capabilities[inlay_hint_key] = true
    end
end

-- LSPs with default config
for lsp_name, lsp_options in pairs(lsp_services) do
    lsp_options.on_init = function(client, bufnr)
        nvchad_lsp_config.on_init(client, bufnr)
        enable_inlay_hints(client)
    end
    lsp_options.on_attach = function(client, bufnr)
        nvchad_lsp_config.on_attach(client, bufnr)
        enable_inlay_hints(client)
    end
    lsp_options.capabilities = nvchad_lsp_config.capabilities
    default_lsp_config[lsp_name].setup(lsp_options)
end

default_lsp_config.lua_ls.setup {
    on_init = function(client)
        local path = client.workspace_folders[1].name
        if
            vim.loop.fs_stat(path .. "/.luarc.json") or vim.loop.fs_stat(path .. "/.luarc.jsonc")
        then
            return
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                },
            },
        })
        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        enable_inlay_hints(client)
    end,
    on_attach = function(client, bufnr)
        nvchad_lsp_config.on_attach(client, bufnr)
        enable_inlay_hints(client)
    end,
    settings = {
        Lua = {},
    },
}
