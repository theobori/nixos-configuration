{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.services.virtualisation.flatpak;
in
{
  options.${namespace}.services.virtualisation.flatpak = {
    enable = mkBoolOpt false "Enable flatpak virtualisation.";
  };

  config = mkIf cfg.enable { services.flatpak = enabled; };
}
