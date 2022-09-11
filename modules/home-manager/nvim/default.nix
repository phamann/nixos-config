{ pkgs, lib, config, ... }:
with lib; let
  cfg = config.modules.nvim;
in {
  options.modules.nvim = {enable = mkEnableOption "nvim";};
  config =
    mkIf cfg.enable {
        programs.neovim = {
            enable = true;
            extraConfig = "luafile ~/.config/nvim/main.lua";
            plugins = with pkgs.vimPlugins; [
                {
                    plugin = filetype-nvim;
                    config = "luafile ~/.config/nvim/plugin/filetype.lua";
                }
                FixCursorHold-nvim
                {
                    plugin = nvim-web-devicons;
                    config = "luafile ~/.config/nvim/plugin/web-devicons.lua";
                }
                plenary-nvim
                telescope-fzf-native-nvim
                vim-surround
                vim-highlightedyank
                {
                    plugin = move-nvim;
                    config = "luafile ~/.config/nvim/plugin/move.lua";
                }
                vim-gh-line
                {
                    plugin = material-nvim;
                    config = "luafile ~/.config/nvim/plugin/material.lua";
                }
                {
                    plugin = nvim-treesitter;
                    config = "luafile ~/.config/nvim/plugin/treesitter.lua";
                }
                {
                    plugin = spellsitter-nvim;
                    config = ''lua require("spellsitter").setup()'';
                }
                {
                    plugin = telescope-nvim;
                    config = "luafile ~/.config/nvim/plugin/telescope.lua";
                }
                {
                    plugin = nvim-tree-lua;
                    config = "luafile ~/.config/nvim/plugin/tree.lua";
                }
                {
                    plugin = lualine-nvim;
                    config = "luafile ~/.config/nvim/plugin/lualine.lua";
                }
                {
                    plugin = ack-vim;
                    config = "luafile ~/.config/nvim/plugin/ack.lua";
                }
                {
                    plugin = kommentary;
                    config = "luafile ~/.config/nvim/plugin/kommentary.lua";
                }
                {
                    plugin = gitsigns-nvim;
                    config = ''lua require("gitsigns").setup()'';
                }
                {
                    plugin = dressing-nvim;
                    config = ''lua require("dressing").setup()'';
                }
                {
                    plugin = toggleterm-nvim;
                    config = ''lua require("toggleterm").setup()'';
                }
                {
                    plugin = which-key-nvim;
                    config = ''lua require("which-key").setup()'';
                }
                {
                    plugin = nvim-colorizer-lua;
                    config = ''lua require("colorizer").setup()'';
                }
                {
                    plugin = indent-blankline-nvim;
                    config = "luafile ~/.config/nvim/plugin/indent.lua";
                }
                {
                    plugin = trim-nvim;
                    config = "luafile ~/.config/nvim/plugin/trim.lua";
                }
                {
                    plugin = diffview-nvim;
                    config = "luafile ~/.config/nvim/plugin/diffview.lua";
                }
                {
                    plugin = nvim-spectre;
                    config = "luafile ~/.config/nvim/plugin/spectre.lua";
                }
                {
                    plugin = nvim-cmp;
                    config = "luafile ~/.config/nvim/plugin/cmp.lua";
                }
                cmp-buffer
                cmp-nvim-lsp
                cmp-path
                cmp-vsnip
                vim-vsnip
                vim-vsnip-integ
                nvim-lspconfig
                {
                    plugin = nvim-lspconfig;
                    config = "luafile ~/.config/nvim/plugin/lsp-config.lua";
                }
                {
                    plugin = fidget-nvim;
                    config = ''lua require("fidget").setup()'';
                }
                {
                    plugin = trouble-nvim;
                    config = ''lua require("trouble").setup()'';
                }
                {
                    plugin = nvim-lightbulb;
                    config = "luafile ~/.config/nvim/plugin/lightbulb.lua";
                }
                {
                    plugin = nvim-lint;
                    config = "luafile ~/.config/nvim/plugin/lint.lua";
                }
                {
                    plugin = nvim-code-action-menu;
                    config = "luafile ~/.config/nvim/plugin/code-action-menu.lua";
                }
                rust-tools-nvim
            ];
        };
        xdg.configFile = {
          nvim = {
            source = ./lua;
            recursive = true;
          };
        };
    };
}
