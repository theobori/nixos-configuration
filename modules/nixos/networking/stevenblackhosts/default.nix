{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.networking.stevenBlackHosts;
in
{
  options.${namespace}.networking.stevenBlackHosts = {
    enable = mkBoolOpt false "Whether or not to enable the Steven Black's hosts.";
  };

  config = mkIf cfg.enable {
    networking.stevenBlackHosts = {
      enable = true;
      blockFakenews = true;
      blockGambling = true;
      blockPorn = true;
      blockSocial = false;
    };
  };
}
