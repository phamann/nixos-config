require("nvim-treesitter.configs").setup({
  parser_install_dir = "~/.config/nvim/parsers",
  ensure_installed = {
      "bash",
      "c",
      "cmake",
      "css",
      "dockerfile",
      "go",
      "gomod",
      "gowork",
      "hcl",
      "help",
      "html",
      "http",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "nix",
      "python",
      "regex",
      "ruby",
      "rust",
      "toml",
      "vim",
      "yaml",
      "zig"
  },
  highlight = {
    enable = true,
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
})
vim.opt.runtimepath:append("~/.config/nvim/parsers")
