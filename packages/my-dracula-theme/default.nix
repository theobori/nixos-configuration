{ pkgs, lib, ... }:
pkgs.dracula-theme.overrideAttrs (
  finalAttrs: previousAttrs: {
    pname = "my-dracula-theme";

    postInstall = ''
      cp ${pkgs.theobori-org.wallpapers.nix-simple} $out/share/sddm/themes/Dracula/assets/background.jpg

      # Collision with stylix
      rm -f $out/share/color-schemes/Dracula.colors
    '';
  }
)
