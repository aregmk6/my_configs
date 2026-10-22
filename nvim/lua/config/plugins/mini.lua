-- lua/custom/plugins/mini.lua
return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require('mini.statusline')
      local icons = require('mini.icons')
      local tabline = require('mini.tabline')
      statusline.setup { use_icons = true }
      icons.setup()
      tabline.setup({
        format = function(buf_id, label)
          local prefix = vim.bo[buf_id].modified and ' +' or ''
          return prefix .. MiniTabline.default_format(buf_id, label)
        end,
      })
    end
  }
}
