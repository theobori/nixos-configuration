{
  config,
  lib,
  inputs,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.cli.programs.ssh;
in
{
  options.${namespace}.cli.programs.ssh = with types; {
    enable = mkBoolOpt false "Whether or not to configure ssh support.";
    extraConfig = mkOpt str "" "Extra configuration to apply.";
  };

  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;

      inherit (cfg) extraConfig;
    };
  };
}
