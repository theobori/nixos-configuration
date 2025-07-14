{ pkgs, ... }:
pkgs.gnomeExtensions.remove-clock.overrideAttrs (
  _finalAttrs: _previousAttrs: {
    pname = "my-remove-clock";

    patches = [
      ./gnome-version.patch
    ];
  }
)
