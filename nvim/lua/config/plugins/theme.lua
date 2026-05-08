return {
  "Alligator/accent.vim",
  config = function()
    vim.cmd.colorscheme("accent")
  end,
}

-- return
-- {
-- 	"catppuccin/nvim",
-- 	name = "catppuccin",
-- 	priority = 1000,
-- 	config = function()
-- 		require("catppuccin").setup {
-- 			color_overrides = {
-- 				all = {
-- 					text = "#ffffff",
-- 					base = "#181818",
-- 					mantle = "#242424",
-- 					crust = "#474747",
-- 				},
-- 				latte = {},
-- 				frappe = {},
-- 				macchiato = {},
-- 				mocha = {},
-- 			}
-- 		}
--
-- 		vim.cmd.colorscheme("catppuccin")
-- 	end,
-- }

-- return { "folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end },
