-- Highlight when yanking (copying) text
-- Try it with `yap` in normal mode
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- when the terminal opens it removes the line numbers
vim.api.nvim_create_autocmd('TermOpen', {
    desc = 'Terminal Opening Config',
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

-- cd to where you left off from in the terminal -> requires wrapper around nvim command.
vim.api.nvim_create_autocmd('VimLeave', {
    desc = 'cd to current dir',
    callback = function()
        local cache_file = vim.fn.expand("~/.cache/nvim/last_cwd")
        local f = io.open(cache_file, 'w')
        if f then
            f:write(vim.fn.getcwd())
            f:close()
        end
    end,
})
