{ pkgs, namespace, ... }:
pkgs.dracula-theme.overrideAttrs (
  _finalAttrs: _previousAttrs: {
    pname = "my-dracula-theme";

    postInstall = ''
      cp ${pkgs.${namespace}.wallpapers.nix-simple} $out/share/sddm/themes/Dracula/assets/background.jpg

      # Collision with stylix
      rm -f $out/share/color-schemes/Dracula.colors
    '';
  }
)
