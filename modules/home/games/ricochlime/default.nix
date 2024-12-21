{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.games.ricochlime;
in
{
  options.${namespace}.games.ricochlime = {
    enable = mkBoolOpt false "Enable ricochlime.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      services.flatpak.packages = [ "flathub:app/com.adilhanney.ricochlime//stable" ];
    };
  };
}
