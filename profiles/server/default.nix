{ config, lib, inputs, ...}: {
  imports = [ ../../modules/default.nix ];
  config.modules = {
    # cli
    zsh.enable = true;
    starship.enable = true;
    ssh.enable = true;
    git.enable = true;
    fzf.enable = true;
    nvim.enable = true;
    z.enable = true;
    gpg.enable = true;
    tmux.enable = true;

    # system
    packages.enable = true;
  };
}
