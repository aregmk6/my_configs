-- lua/custom/plugins/mini.lua
return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require('mini.statusline')
      local icons = require('mini.icons')
      local tabline = require('mini.tabline')
      -- local misc = require('mini.misc')
      statusline.setup { use_icons = true }
      icons.setup()
      tabline.setup()
      -- misc.setup()
    end
  }
}
