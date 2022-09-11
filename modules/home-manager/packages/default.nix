{ pkgs, lib, config, ... }:
with lib; let
  cfg = config.modules.packages;
in
{
  options.modules.packages = { enable = mkEnableOption "packages"; };
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

        starship
        kitty
        docker
        google-cloud-sdk

        # Language tools
        go
        gopls
        rnix-lsp
        nixpkgs-fmt
      ];
    };
}
