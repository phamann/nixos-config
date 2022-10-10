{ self, inputs, config , pkgs,  ...}: {
  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  # Enable ZSH as we use it as our default shell for all users.
  # This will also get configured per user profile.
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit self inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  environment.systemPackages = with pkgs; [
      # editors
      neovim

      # standard toolset
      coreutils-full
      gnumake
      curl
      wget
      dig
      git
      jq
      tmux

      # helpful shell stuff
      direnv
      nix-direnv
      bat
      fzf
      ripgrep

      # tailscale
      unstable.tailscale
  ];

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings = {
        max-jobs = 8;
        auto-optimise-store = true;
        allowed-users = [ "phamann" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    readOnlyStore = true;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # We expect to run on hidpi machines.
  hardware.video.hidpi.enable = true;

  # Boot settings: clean /tmp/, latest kernel, and enable bootloader
  boot = {
    cleanTmpDir = true;
    # Be careful updating this.
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.consoleMode = "0";
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [ jetbrains-mono ];
  };

  environment.variables = {
    NIXOS_CONFIG = "$HOME/.config/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    EDITOR = "nvim";
  };

  environment.pathsToLink = [
    "/share/nix-direnv"
  ];

  # Direnv flake support
  nixpkgs.overlays = [
    (self: super: { nix-direnv = super.nix-direnv.override { enableFlakes = true; }; })
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowBroken = false;
    allowUnsupportedSystem = true;
  };

  # Don't require password for sudo
  security.sudo.wheelNeedsPassword = false;

  # Virtualization settings
  virtualisation.docker.enable = true;

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
      allowedUDPPortRanges = [
        {
          from = 60000;
          to = 60010;
        }
      ];
      # tailscale
      checkReversePath = "loose";
    };
  };

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
    permitRootLogin = "no";
  };

  # https://fzakaria.com/2020/09/17/tailscale-is-magic-even-more-so-with-nixos.html
  # enable the tailscale daemon; this will do a variety of tasks:
  # 1. create the TUN network device
  # 2. setup some IP routes to route through the TUN
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}
