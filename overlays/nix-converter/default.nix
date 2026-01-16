{ channels, ... }:

_final: _prev: {
  inherit (channels.unstable) nix-converter;
}
