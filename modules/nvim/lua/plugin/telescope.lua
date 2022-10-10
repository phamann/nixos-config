local actions = require("telescope.actions")
require("telescope").setup({
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-o>"] = actions.send_selected_to_qflist,
      },
    },
    file_ignore_patterns = { "node%_modules/.*", "target/.*", ".git/.*", ".terraform/.*" },
    layout_config = {
        preview_width = 0.6,
    },
  },
  extensions = {
    heading = {
      treesitter = true,
    },
  },
})

require('telescope').load_extension("fzf")

vim.g.telescope_changed_files_base_branch = "main"

vim.keymap.set("n", "<leader>f", "<Cmd>Telescope find_files hidden=true<CR>", { desc = "search files" })
vim.keymap.set("n", "<C-p>", "<Cmd>Telescope find_files hidden=true<CR>", { desc = "search files" })
vim.keymap.set("n", "<leader>t", "<Cmd>Telescope live_grep<CR>", { desc = "search text" })
vim.keymap.set("n", "<leader>b", "<Cmd>Telescope buffers<CR>", { desc = "search buffers" })
vim.keymap.set("n", "<leader>l", "<Cmd>Telescope buffers<CR>", { desc = "search buffers" })
vim.keymap.set("n", "<leader>h", "<Cmd>Telescope help_tags<CR>", { desc = "search help" })
vim.keymap.set("n", "<leader>c", "<Cmd>Telescope colorscheme<CR>", { desc = "search colorschemes" })
vim.keymap.set("n", "<leader>q", "<Cmd>Telescope quickfix<CR>", { desc = "search quickfix list" })
vim.keymap.set("n", "<leader>r", "<Cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "search current buffer text" })
vim.keymap.set("n", "<leader>tr", "<Cmd>Telescope lsp_references<CR>", { desc = "search code reference" })
vim.keymap.set("n", "<leader>ts", "<Cmd>Telescope lsp_document_symbols<CR>", { desc = "search document tree" })
