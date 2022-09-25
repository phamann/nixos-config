{
  description = "Patrick Hamann's NixOS system configuration";

  inputs = {
    # Pin the primary nixpkgs repository. This is the main nixpkgs repository
    # used for all configurations. Be very careful changing this because
    # it'll impact the entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

    nixos-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";

      # Ensure home-manager uses the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom nvim plugins
    # TODO: Upstream these to nixpkgs, so I no longer need to do this.
    filetype-nvim = {
        url = "github:nathom/filetype.nvim";
        flake = false;
    };
    spellsitter-nvim = {
        url = "github:lewis6991/spellsitter.nvim";
        flake = false;
    };
    trim-nvim = {
        url = "github:cappyzawa/trim.nvim";
        flake = false;
    };
    move-nvim = {
        url = "github:fedepujol/move.nvim";
        flake = false;
    };
    nvim-tree-lua = {
        url = "github:kyazdani42/nvim-tree.lua";
        flake = false;
    };
    nvim-treesitter = {
        url = "github:nvim-treesitter/nvim-treesitter/3e0cc6b872116d829e56629b442526e057e5724e";
        flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: let

    isDarwin = system:
        (builtins.elem system inputs.nixpkgs.lib.platforms.darwin);
    homePrefix = system: if isDarwin system then "/Users" else "/home";

    # Custom nvim plugins
    vimPlugins = {
        inherit (inputs)
            filetype-nvim spellsitter-nvim trim-nvim move-nvim nvim-tree-lua nvim-treesitter;
    };

    # Generate a base nixos configuration with the specified overlays,
    # hardware modules, and any extraModules applied.
    mkNixosConfig =
        {
            system ? "x86_64-linux",
            nixpkgs ? inputs.nixos-unstable,
            stable ? inputs.stable,
            hostname,
            username ? "phamann",
            hardwareModules ? [
                (./. + "/modules/hardware/${hostname}.nix")
            ],
            hostModules ? [
                (./. + "/modules/hosts/${hostname}.nix")
            ],
            baseModules ? [
                { networking.hostName = hostname; }
                ./modules/common
                ./modules/nixos
                home-manager.nixosModules.home-manager {
                    home-manager.users.${username} = import ./modules/home-manager;
                }
                (./. + "/users/${username}.nix")
                {
                  nixpkgs.overlays = [
                    (import ./overlays/vim-plugins.nix nixpkgs vimPlugins system)
                  ];
                }
            ],
            extraModules ? []
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules =
            baseModules ++ hardwareModules ++ hostModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs; };
        };

    mkSystem = pkgs: system: hostname: user:
      pkgs.lib.nixosSystem {
        system = system;
        modules = [
            (./. + "/modules/hardware/${hostname}.nix")
            (./. + "/modules/hosts/${hostname}.nix")
            (./. + "/users/${user}/nixos.nix")
            {
                nixpkgs.overlays = [
                    (import ./overlays/vim-plugins.nix nixpkgs vimPlugins system)
                ];
            }
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = import ./users/${user}/home.nix;
              home-manager.extraSpecialArgs = { inherit inputs; };
            }

            {
              # https://github.com/NixOS/nixpkgs/blob/58088cb7978176f3cff387ebb4e3bc2716e7ce4d/lib/modules.nix#L172
              config._module.args = {
                currentSystemName = hostname;
                currentSystem = system;
              };
            }
        ];
        specialArgs = {inherit inputs;};
      };
    in {
      nixosConfigurations = {
        /* vm-aarch64 = mkSystem inputs.nixpkgs "aarch64-linux" "vm-aarch64" "phamann"; */
        vm-aarch64 = mkNixosConfig {
            system = "aarch64-linux";
            hostname = "vm-aarch64";
            username = "phamann";
        };
      };
    };
}
