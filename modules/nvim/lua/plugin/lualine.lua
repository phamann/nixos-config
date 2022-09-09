require("lualine").setup({
  options = {
    globalstatus = true,
    theme = "material-stealth",
    disabled_filetypes = { 'packer', 'NvimTree', 'Diffview' },
  },
})
vim.go.showtabline = 0
