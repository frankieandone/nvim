local autocmd = vim.api.nvim_create_autocmd

autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        local line = vim.fn.line "'\""
        if
            line > 1
            and line <= vim.fn.line "$"
            and vim.bo.filetype ~= "commit"
            and vim.fn.index({ "xxd", "gitrebase" }, vim.bo.filetype) == -1
        then
            vim.cmd 'normal! g`"'
        end
    end,
})

autocmd("LspAttach", {
    callback = function(args)
        vim.defer_fn(function()
            vim.lsp.inlay_hint.enable(true, { bufnr = vim.api.nvim_get_current_buf() })
        end, 300)
    end,
})

print "loaded autocmds"
