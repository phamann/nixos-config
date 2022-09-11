vim.g.material_style = "palenight"

require('material').setup({
    contrast = {
        sidebars = false,
        floating_windows = true,
        cursor_line = true,
        non_current_windows = true,
    },

	italics = {
		comments = true,
	},

    high_visibility = {
		lighter = true,
	},

    custom_colors = {
        bg_nc  = '#262a3a',
        bg_cur = '#242837',
        float  = '#222634',
    },
})

vim.cmd("colorscheme material");

vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#303c5c", nocombine = true})
vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#A6ACCD", nocombine = true})
vim.api.nvim_set_hl(0, "IndentBlanklineSpaceChar", { fg = "#303c5c", nocombine = true})
vim.api.nvim_set_hl(0, "IndentBlanklineContextSpaceChar", { fg = "#303c5c", nocombine = true})

vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#3A3F58" })
