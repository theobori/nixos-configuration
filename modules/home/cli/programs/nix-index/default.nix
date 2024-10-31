{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.cli.programs.nix-index;
in
{
  options.${namespace}.cli.programs.nix-index = {
    enable = mkBoolOpt false "Whether or not to nix index.";
  };

  config = mkIf cfg.enable {
    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.nix-index-database.comma = enabled;
  };
}
