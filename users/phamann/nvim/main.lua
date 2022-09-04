vim.o.backup = false
vim.o.clipboard = "unnamed"
vim.o.cursorline = true
vim.o.dictionary = "/usr/share/dict/words"
vim.o.expandtab = true
vim.o.expandtab = true
vim.o.grepprg = "rg --vimgrep"
vim.o.ignorecase = true
vim.o.inccommand = "split"
vim.o.lazyredraw = true
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 4
vim.o.shortmess = vim.o.shortmess .. "c"
vim.o.showcmd = true
vim.o.showmatch = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spell = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 4
vim.o.wrap = false
vim.o.mouse = "a"
vim.o.showtabline = 0
vim.o.signcolumn = 'yes'
vim.wo.colorcolumn = "80"
vim.wo.relativenumber = true

if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

vim.g.mapleader = "'"

vim.keymap.set("", "±", "<Cmd>nohlsearch<CR>", { desc = "turn off search highlight" })

function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
vim.cmd('autocmd! TermOpen term://* setlocal nospell')

vim.keymap.set("n", "<leader>tt", "<Cmd>ToggleTerm direction=float<CR>", { desc = "toggle floating terminal" })
