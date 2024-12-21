{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.services.flatpak;
in
{
  options.${namespace}.services.flatpak = with types; {
    enable = mkBoolOpt false "Whether to enable flatpak.";
    packages = mkOpt (listOf (oneOf [
      attrs
      str
    ])) [ ] "Flatpak packages.";
    remotes = mkOpt attrs {
      flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    } "Flatpak remote repositories.";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      inherit (cfg) packages remotes;
    };
  };
}
