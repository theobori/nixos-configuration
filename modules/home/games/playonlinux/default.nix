{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.games.playonlinux;
in
{
  options.${namespace}.games.playonlinux = {
    enable = mkBoolOpt false "Enable PlayOnLinux.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      services.flatpak.packages = [ "flathub:app/com.playonlinux.PlayOnLinux4//stable" ];
    };
  };
}
