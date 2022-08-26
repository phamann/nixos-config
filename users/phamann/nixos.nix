{ pkgs, ... }:

{
  users.users.phamann = {
    isNormalUser = true;
    home = "/home/phamann";
    extraGroups = [ "docker" "wheel" ];
    shell = pkgs.zsh;
    # https://github.com/NixOS/nixpkgs/blob/8a053bc2255659c5ca52706b9e12e76a8f50dbdd/nixos/modules/config/users-groups.nix#L43
    # mkpasswd -m sha-512
    hashedPassword = "$6$oWjhi/6j7v$Et59xUTrceVX9LlJZZWy3WgfE3xSJeOXwNMDR7yx4AVWSyQychPqH/ruZgRAHKXL2GvkplJee7tvPiHo3Pdy7.";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDrsRD0PDswOMcbnT7npj94ngqfNZRNh6P9/68ZKTxDgnenSQ+Pv7etLmj7vpZk5gTCbq1AkfUt/QjO9QNcFVPl7ZZkCehJ4+FsLbNt5oYWAmywfWQOOzEz5d8XbgnRS/dLKqPmoIcs0e2hZl69yZ07GOHUrfID7Jg+68YBCIl+9/xRYJxkmHdHZm+1shdUYuOth9CMWFqcxI0g9uqacQBTnRcdnszb1vTf4otZZ9wMRFAwK5gqx9XmyPfluzlD47jc40/Q8vwUL8i2bK0lpNtejW/tWsQgrm/OmnndpyTqOawuR8QAWsy/kLFd+CGQWUpBI1ErYgaMo31JSV0iLhsbPMniOiaEXAn6/w2pJ44y7qJd3NliPiP/bYPW/sZwwmSvLtsT0tpIXChqcqppGAyHAk8L2tSWa8QlytpCO5Q2q8INV1uMBSvZ58t7yPZ+baul8dce2DCskd8PbTv8iSx7UyaRkhVFRhh40Xto7QfKU4gKikqpYPRkgWhNh2dbEYXUnUjCYUyyloFEImeUTJvaHucRQfuBKQXlxkaglIVxulZzyHrLJSs+Y9AYoof4X7ZnjDDl4D3C0newjZrLJr5vigWyIm23qkzDmNfoU8mJ6yMdCUvtmteu5RdcGICxL1r8jVH0oVcxDoSzt2PsazYJ+IVeMsZzrcNrIM9tcYOg2w== phamann@fastly.com"
    ];
  };
}
