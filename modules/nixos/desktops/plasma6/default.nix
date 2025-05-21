{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  # See https://github.com/Toomoch/nixos-config/blob/master/system/modules/de.nix#L4-L12
  discover-wrapped = pkgs.symlinkJoin {
    name = "discover-flatpak-backend";
    paths = with pkgs; [ kdePackages.discover ];
    buildInputs = with pkgs; [ makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/plasma-discover --add-flags "--backends flatpak"
    '';
  };

  cfg = config.${namespace}.desktops.plasma6;
in
{
  options.${namespace}.desktops.plasma6 = {
    enable = mkBoolOpt false "Enable KDE Plasma 6.";
  };

  config = mkIf cfg.enable {
    services.xserver = enabled;

    # services.packagekit = enabled;

    services.desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = true;
    };

    environment.systemPackages = [ discover-wrapped ];
  };
}
