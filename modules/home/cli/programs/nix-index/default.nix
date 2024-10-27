{
  lib,
  config,
  inputs,
  ...
}:
let
  cfg = config.cli.programs.nix-index;
in
{
  options.cli.programs.nix-index = {
    enable = lib.mkEnableOption "Whether or not to nix index";
  };

  imports = with inputs; [ nix-index-database.hmModules.nix-index ];

  config = lib.mkIf cfg.enable {
    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.nix-index-database.comma.enable = true;
  };
}
