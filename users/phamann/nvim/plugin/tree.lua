require("nvim-tree").setup({
    reload_on_bufenter = false,
    update_focused_file = {
        enable = true,
    },
    -- open_on_setup_file = true,
    git = {
        enable = false,
    },
    renderer = {
        highlight_opened_files = "all",
    },
    actions = {
        open_file = {
            quit_on_open = true
        }
    }
})

vim.keymap.set("n", "<leader>;", "<Cmd>NvimTreeToggle<CR>", { desc = "search files" })
