return {
  {
    'saghen/blink.cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
          -- for "rafamadriz/friendly-snippets"
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    version = '1.*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      snippets = { preset = 'luasnip' },
      keymap = { preset = 'default' },
      appearance = {
        nerd_font_variant = 'mono'
      },
      signature = { enabled = true },
      completion = {
        documentation = { auto_show = false },
        menu = {
          auto_show = false,
        },
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
  }
}
