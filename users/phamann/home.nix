{ config, pkgs, lib, ... }: {

  home.username = "phamann";
  home.homeDirectory = "/home/phamann";

  imports = [
    ../../modules/home-manager/packages
    ../../modules/home-manager/zsh
    ../../modules/home-manager/starship
    ../../modules/home-manager/ssh
    ../../modules/home-manager/git
    ../../modules/home-manager/fzf
    ../../modules/home-manager/kitty
    ../../modules/home-manager/nvim
    ../../modules/home-manager/z
    ../../modules/home-manager/gpg
  ];

  modules = {
    packages.enable = true;
    zsh.enable = true;
    starship.enable = true;
    ssh.enable = true;
    git.enable = true;
    fzf.enable = true;
    kitty.enable = true;
    nvim.enable = true;
    z.enable = true;
    gpg.enable = true;
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
