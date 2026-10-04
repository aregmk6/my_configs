-- plugins/telescope.lua:
return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
    config = function()
      require('telescope').setup({
        extensions = {
          fzf = {}
        },
      })

      require('telescope').load_extension('fzf')

      local function get_path()
        local oil_prefix = "oil://"
        local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
        if string.find(path, oil_prefix, 1, true) then
          path = string.sub(path, #oil_prefix + 1)
        end
        return path
      end


      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
      vim.keymap.set('n', '<leader>fr', function()
        builtin.find_files({ cwd = get_path() })
      end
      , { desc = 'Telescope find files current directory' })
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope find symbols' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
      vim.keymap.set('n', '<leader>fe', function()
        builtin.live_grep({ cwd = get_path() })
      end, { desc = 'Telescope live grep current directory' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
      vim.keymap.set('n', '<leader>fc', builtin.current_buffer_fuzzy_find, { desc = 'Telescope grep current file' })
      vim.keymap.set('n', '<leader>en', function()
        builtin.find_files({
          cwd = vim.fn.stdpath("config")
        })
      end, { desc = 'Telescope neovim config files' })
    end
  }
}
