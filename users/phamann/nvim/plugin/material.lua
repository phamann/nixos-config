-- Material
vim.g.material_style = "palenight"

require('material').setup({
    contrast = {
        sidebars = false,
        floating_windows = true,
        cursor_line = true,
        non_current_windows = true,
    },

	italics = {
		comments = true, -- Enable italic comments
	},

    high_visibility = {
		lighter = true, -- Enable higher contrast text for lighter style
	},

    custom_colors = {
        bg_nc  = '#262a3a', -- 5%  of bg
        bg_cur = '#242837', -- 10% of bg
        float  = '#222634', -- 15% of bg
    },
})

vim.cmd("colorscheme material");

-- Override indent colours
-- Sadly we must do these here and not plugin/indent.lua as material.nvim overrides them.
vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#303c5c", nocombine = true})
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#A6ACCD", nocombine = true})
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg = "#303c5c", nocombine = true})
vim.api.nvim_set_hl(0, "IndentBlanklineContextSpaceChar", { fg = "#303c5c", nocombine = true})

vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3A3F58" })
