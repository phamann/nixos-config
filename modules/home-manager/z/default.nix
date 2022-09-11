{ pkgs, lib, config, ... }:
with lib; let
  cfg = config.modules.z;
in {
  options.modules.z = {enable = mkEnableOption "z";};
  config =
    mkIf cfg.enable {
        programs.z-lua = {
            enable = true;
            enableZshIntegration = true;
            options = [ "enhanced" "fzf" ];
        };
    };
}
