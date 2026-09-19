return
{
  'nvim-tree/nvim-tree.lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },

  -- empty setup using defaults
  config = function()
    require("nvim-tree").setup()
  end,

}
