return {
  {
    "mason-org/mason.nvim",
    opts = {}
  },

  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {},
    },
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua", -- only load on lua files
        opts = {
          library = {
            -- See the configuration section for more details
            -- Load luvit types when the `vim.uv` word is found
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.lsp.config('lua_ls', { capabilities = capabilities, })
      vim.lsp.config('clangd', { capabilities = capabilities })
      vim.lsp.config('pyright', { capabilities = capabilities })
      vim.lsp.config('ts_ls', { capabilities = capabilities })

      -- I have these installed locally on my system
      vim.lsp.enable('lua_ls')
      vim.lsp.enable('clangd')
      vim.lsp.enable('pyright')
      vim.lsp.enable('ts_ls')
      -- These are from mason

      vim.keymap.set('n', 'gK', function()
        local new_config = not vim.diagnostic.config().virtual_lines
        vim.diagnostic.config({ virtual_lines = new_config })
      end, { desc = 'Toggle diagnostic virtual_lines' })

      vim.keymap.set('v', '<leader>lf', vim.lsp.buf.format, { desc = 'Toggle diagnostic virtual_lines' })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          -- Auto-format ("lint") on save.
          -- Usually not needed if server supports "textDocument/willSaveWaitUntil".
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })
    end,
  }
}
