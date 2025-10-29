{ ... }:

_final: _prev: {
  #  > Program spirv-remap found: NO
  #  >
  #  > meson.build:51:14: ERROR: Program 'spirv-remap' not found or not executable
  #  nix log /nix/store/wgk345pzvf2q4srii43d0h98nazl4im9-vkquake-1.32.3.1.drv
  #
  # inherit (channels.unstable) vkquake;
}
