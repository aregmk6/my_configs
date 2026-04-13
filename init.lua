print("sourced init.lua, advent of code - tutorial")

require("config.lazy")

vim.opt.shiftwidth = 2
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
-- vim.o.splitright = true
-- vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 5

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- [[ Basic Keymaps ]]
-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>")
vim.keymap.set("n", "<leader>wa", "<cmd>wa<CR>")

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- source lines in buffer
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", "<cmd>.lua<CR>")
vim.keymap.set("v", "<space>x", "<cmd>lua<CR>")

-- travers QuickFix manu
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

-- open parent directory with oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<M-->", function()
  vim.cmd("new")
  vim.cmd("Oil")
end, { desc = "Open parent directory" })

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
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

-- open terminal
local job_id = 0
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  job_id = vim.bo.channel
end)

-- open terminal and run 'make' command
vim.keymap.set("n", "<space>tm", function()
  vim.fn.chansend(job_id, { "make\r" })
end)

-- cpp assist bindings

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- switch between source and header
map('n', '<leader>sw', '<Cmd>SwitchSourceAndHeader<CR>', opts)
-- generate the function definition or static variable definition in source
map('n', '<leader>cf', '<Cmd>ImplementInSource<CR>', opts)
-- generate the function definition or static variable definition in source in visual mode
map('v', '<leader>cf', '<Cmd>lua require("cppassist").ImplementInSourceInVisualMode<CR>', opts)
-- generate the function definition or static variable definition in header
map('n', '<leader>cv', '<Cmd>ImplementOutOfClass<CR>', opts)
-- goto the header file
map('n', '<leader>gh', '<Cmd>GotoHeaderFile<CR>', opts)
