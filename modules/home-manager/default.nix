{ self, inputs, config, pkgs, ... }: {
  imports = [
    ./packages
    ./zsh
    ./starship
    ./ssh
    ./git
    ./fzf
    ./kitty
    ./nvim
    ./z
    ./gpg
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

  programs.home-manager = {
    enable = true;
    path = "${config.home.homeDirectory}/.nixpkgs/modules/home-manager";
  };

  home = {
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "22.05";
  };
}
