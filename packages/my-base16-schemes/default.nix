{ pkgs, ... }:
pkgs.base16-schemes.overrideAttrs (
  _finalAttrs: _previousAttrs: {
    pname = "my-base16-schemes";

    patches = [
      ./base16-dracula-old.patch
    ];
  }
)
