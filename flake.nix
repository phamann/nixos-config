{
  description = "Patrick Hamann's NixOS system configuration";

  inputs = {
    # Pin our primary nixpkgs repository. This is the main nixpkgs repository
    # we'll use for our configurations. Be very careful changing this because
    # it'll impact your entire system.
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";

    # We use the unstable nixpkgs repo for some packages.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";

      # We want home-manager to use the same set of nixpkgs as our system.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom nvim plugins
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
  };

  outputs = {
      self,
      nixpkgs,
      home-manager,
      filetype-nvim,
      spellsitter-nvim,
      trim-nvim,
      move-nvim,
      ...
  } @ inputs: let
    /* mkHost = import ./lib/mkhost.nix; */
    customVimPluginsToBuild = {
        inherit filetype-nvim spellsitter-nvim trim-nvim move-nvim;
    };
    buildVimPlugin = system: plugin:
        let inherit (nixpkgs.legacyPackages.${system}) vimUtils;
        in vimUtils.buildVimPluginFrom2Nix plugin;
    buildAllVimPlugins = system:
        builtins.mapAttrs (pluginName: plugin:
          buildVimPlugin system {
            pname = pluginName;
            version = plugin.rev or self.rev or "dirty";
            src = plugin;
          }) customVimPluginsToBuild;
    mkSystem = pkgs: system: hostname: user:
      let
        customVimPlugins = buildAllVimPlugins system;
        customVimPluginOverlay = final: prev: {
            vimPlugins = prev.vimPlugins // customVimPlugins;
        };
      in
      pkgs.lib.nixosSystem {
        system = system;
        modules = [
            (./. + "/hardware/${hostname}.nix")
            (./. + "/machines/${hostname}.nix")
            (./. + "/users/${user}/nixos.nix")
            {
                nixpkgs.overlays = [customVimPluginOverlay];
            }
            home-manager.nixosModules.home-manager {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = import ./users/${user}/home-manager.nix;
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
