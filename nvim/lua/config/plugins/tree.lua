return
{
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  -- empty setup using defaults
  config = function()
    require("nvim-tree").setup()

    -- tree toggle
    vim.keymap.set("n", "<leader>et", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })
  end,

}
