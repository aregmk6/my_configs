-- Emacs movement for command mode
vim.keymap.set('c', '<C-q>', '<C-f>', { desc = 'open command history' })
vim.keymap.set('c', '<M-b>', '<S-Left>', { desc = 'move backward one word' })
vim.keymap.set('c', '<M-f>', '<S-Right>', { desc = 'move forward one word' })
vim.keymap.set('c', '<C-b>', '<Left>', { desc = 'move backward one character' })
vim.keymap.set('c', '<C-f>', '<Right>', { desc = 'move forward one character' })

-- Emacs movement for insert mode
vim.keymap.set('i', '<M-b>', '<C-o>b', { desc = 'move forward one word' })
vim.keymap.set('i', '<M-f>', '<C-o>w', { desc = 'move backward one word' })
vim.keymap.set('i', '<C-d>', '<Delete>', { desc = 'Delete character under cursor' })
vim.keymap.set('i', '<M-d>', '<C-o>dw', { desc = 'Delete word under cursor' })
vim.keymap.set('i', '<C-k>', '<C-o>D', { desc = 'Kill text to end of line' })
vim.keymap.set('i', '<C-f>', '<C-o>l', { desc = 'Delete word under cursor' })
vim.keymap.set('i', '<C-b>', '<C-o>h', { desc = 'Kill text to end of line' })

-- rtlke
local flag1 = false
vim.keymap.set({ 'n', 'i', 'v' }, '<F2>', function()
  if (not flag1) then
    vim.opt.rightleft = true
    vim.opt.keymap = "hebrew"
    flag1 = true
  else
    vim.opt.rightleft = false
    vim.opt.keymap = ""
    flag1 = false
  end
end, { desc = "Toggle RTL layout mode" })

local flag2 = false
vim.keymap.set({ 'n', 'i', 'v' }, '<F3>', function()
  if (not flag2) then
    vim.opt.rightleftcmd = "search"
    flag2 = true
  else
    vim.opt.rightleftcmd = ""
    flag2 = false
  end
end, { desc = "Toggle RTL cmd layout mode" })

-- select what's highlighted
vim.keymap.set("v", "/", [[y/<C-r>0<CR>]], { desc = "select what's highlighted" })

-- cd to current pwd
vim.keymap.set("n", "<leader>cd", function()
  local oil_prefix = "oil://"
  local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  if string.find(path, oil_prefix, 1, true) then
    path = string.sub(path, #oil_prefix + 1)
  end
  print("Switched to: " .. path)
  vim.cmd("cd " .. path)
end
, { desc = "set current directory as cwd" })

-- Toggle line wrapping
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap", silent = true })

-- Fix spelling (picks first suggestion)
vim.keymap.set("n", "z0", "1z=", { desc = "Fix word under cursor" })

-- replace under cursor
vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "change occors of word under cursor accros whole file" })
vim.keymap.set("v", "<leader>s", [[y:s/<C-r>0/<C-r>0/gI<Left><Left><Left>]],
  { desc = "change occors of word under cursor in visual selection" })
-- vim.keymap.set("n", "<leader>sl", [[:.s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]],
--   { desc = "change occors of word under cursor in current line" })
vim.keymap.set("n", "<leader>qr", [[:%s//g<left><left>]],
  { desc = "quary replace in accros file" })
vim.keymap.set("v", "<leader>qr", [[:s//g<left><left>]],
  { desc = "quary replace visual selection" })

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard" })

-- quick save
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "save changes on current buffer" })
vim.keymap.set("n", "<leader>wa", "<cmd>wa<CR>", { desc = "save changes on all open buffers" })
vim.keymap.set("n", "<leader>nw", "<cmd>noa w<CR>", { desc = "no autocommand - save changes on all open buffers" })
vim.keymap.set("n", "<leader>nwa", "<cmd>noa wa<CR>", { desc = "no autocommand - save changes on all open buffers" })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = "Clear highlights" })

-- source lines in buffer
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>", { desc = "source current file in buffer"})
vim.keymap.set("v", "<space>x", "<cmd>lua<CR>", { desc = "run highlighted command" })

-- travers QuickFix manu
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")
vim.keymap.set("n", "<M-q>", "<cmd>cclose<CR>")

-- open parent directory with oil
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<M-->", function()
  vim.cmd("vnew")
  vim.cmd("Oil")
end, { desc = "Open parent directory in new window" })

-- diagnostics
local toggle = false
vim.keymap.set("n", "<space><S-d>", function()
  toggle = not toggle
  vim.diagnostic.enable(toggle)
end
, { desc = "toggle diagnostics" })

-- buffers
vim.keymap.set("n", "<tab>", "<cmd>bnext<cr>", { desc = "next buffer" })
vim.keymap.set("n", "<S-tab>", "<cmd>bprev<cr>", { desc = "prev buffer" })
vim.keymap.set("n", "<space>bb", "<cmd>bdelete<cr>", { desc = "close buffer" })
vim.keymap.set("n", "<space>bd", function()
  local function buffer_filter(buf)
    if not vim.api.nvim_buf_is_valid(buf) or not vim.api.nvim_buf_get_option(buf, 'buflisted') then
      return false
    end
    return true
  end

  local buffers = vim.tbl_filter(buffer_filter, vim.api.nvim_list_bufs())
  local non_hidden_buffer = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    non_hidden_buffer[vim.api.nvim_win_get_buf(win)] = true
  end

  for _, buffer in ipairs(buffers) do
    if non_hidden_buffer[buffer] == nil then
      vim.cmd({ cmd = 'bdelete', args = { buffer } })
    end
  end
end
, { desc = "close all other buffers except for the one that is open" })

-- show messages as a buffer:

vim.keymap.set("n", "<leader>mm", function()
  local m = vim.fn.execute('messages')
  vim.cmd('new')
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(m, '\n'))
end
, { desc = "show messages as a buffer" })

-- run built in terminal
vim.keymap.set("n", "<space>x", function() 
    vim.ui.input({ prompt = "Terminal Command: "}, function(input) 
        if input and input ~= "" then
            vim.cmd('botright split | term ' .. input)
        end
    end)
end, { desc = "run command in terminal"})
