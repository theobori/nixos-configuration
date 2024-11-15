{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkOpt mkBoolOpt;

  cfg = config.${namespace}.cli.programs.nh;
in
{
  options.${namespace}.cli.programs.nh = with types; {
    enable = mkBoolOpt false "Whether or not to enable nh.";
    flake = mkOpt str "/etc/nixos/${namespace}" "NixOS flake configuration path";
  };

  config = mkIf cfg.enable {
    programs.nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      inherit (cfg) flake;
    };
  };
}
