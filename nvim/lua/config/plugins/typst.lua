return {
  'chomosuke/typst-preview.nvim',
  lazy = false, -- or ft = 'typst'
  version = '1.*',
  opts = {
  }, -- lazy.nvim will implicitly calls `setup {}`
  config = function()
    vim.keymap.set('n', '<leader>lt', '<cmd>TypstPreviewToggle<CR>', { desc = 'Telescope find files' })
  end,
}
