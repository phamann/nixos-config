{
  description = "Patrick Hamann's NixOS system configuration";

  inputs = {
    # Pin the primary nixpkgs repository. This is the main nixpkgs repository
    # used for all configurations. Be very careful changing this because
    # it'll impact the entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

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
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs: let
    buildVimPlugins = import ./lib/build-vim-plugins.nix;

    # Map of custom vim plugins to build.
    vimPluginsToBuild = {
        inherit (inputs)
            filetype-nvim spellsitter-nvim trim-nvim move-nvim nvim-tree-lua;
    };

    # Generate a base nixos configuration with the specified overlays,
    # hardware modules, and any extraModules applied.
    mkNixosConfig =
        {
            system ? "x86_64-linux",
            nixpkgs ? inputs.nixos-unstable,
            stable ? inputs.stable,
            hardwareModules,
            baseModules ? [
                home-manager.nixosModules.home-manager
                ./modules/nixos
            ],
            extraModules ? [ ]
        }:
        nixpkgs.lib.nixosSystem {
          inherit system;
          modules = baseModules ++ hardwareModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs; };
        };

    mkSystem = pkgs: system: hostname: user:
      let
        vimPlugins = buildVimPlugins nixpkgs system vimPluginsToBuild;
        vimPluginOverlay = final: prev: {
            vimPlugins = prev.vimPlugins // vimPlugins;
        };
      in
      pkgs.lib.nixosSystem {
        system = system;
        modules = [
            (./. + "/modules/hardware/${hostname}.nix")
            (./. + "/modules/hosts/${hostname}.nix")
            (./. + "/users/${user}/nixos.nix")
            {
                nixpkgs.overlays = [vimPluginOverlay];
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
        vm-aarch64 = mkSystem inputs.nixpkgs "aarch64-linux" "vm-aarch64" "phamann";
      };
    };
}
