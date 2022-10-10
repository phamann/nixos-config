{ inputs, pkgs, config, ... }: {
  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/.nixpkgs/modules/home-manager";
  };
  imports = [
    # cli
    ./zsh
    ./starship
    ./ssh
    ./git
    ./fzf
    ./nvim
    ./z
    ./gpg
    ./tmux

    # gui
    ./kitty

    # system
    ./packages
  ];
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";
}
