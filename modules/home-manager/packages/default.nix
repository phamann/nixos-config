{ pkgs, lib, config, ... }:
with lib; let
  cfg = config.modules.packages;
in {
  options.modules.packages = {enable = mkEnableOption "packages";};
  config =
    mkIf cfg.enable {
        home.packages = with pkgs; [
            bat
            fd
            fzf
            gcc
            htop
            jq
            ripgrep
            pinentry-curses
            subnetcalc
            tree
            watch
            niv
            grc
            z-lua

            zsh-vi-mode
            zsh-fzf-tab
            zsh-z
            zsh-autosuggestions
            zsh-history-substring-search
            zsh-syntax-highlighting

            go
            gopls

            starship
            kitty
            docker
            google-cloud-sdk
            nodePackages.dockerfile-language-server-nodejs
            nodePackages.lua-fmt
            nodePackages.yaml-language-server
            rnix-lsp
        ];
    };
}
