-- Toggle line wrapping
vim.keymap.set("n", "<leader>tw", "<cmd>set wrap!<CR>", { desc = "Toggle Wrap", silent = true })

-- Fix spelling (picks first suggestion)
vim.keymap.set("n", "z0", "1z=", { desc = "Fix word under cursor" })

-- replace under cursor
vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- quick save
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
end, { desc = "Open parent directory in new window" })

-- open terminal
local job_id = 0
vim.keymap.set("n", "<space>st", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 15)
  job_id = vim.bo.channel
end)

-- go into normal mode in terminal
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
vim.keymap.set("t", "<C-w>q", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- open terminal and run 'make' command
vim.keymap.set("n", "<space>tm", function()
  vim.fn.chansend(job_id, { "make\r" })
end)

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
vim.keymap.set("n", "<space>bd", "<cmd>bdelete<cr>", { desc = "close buffer" })
vim.keymap.set("n", "<space>bhd", function()
  function buffer_filter(buf)
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
      vim.cmd("bdelete" .. ' ' .. buffer)
    end
  end
end
, { desc = "close buffer" })
