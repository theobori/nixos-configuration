{ channels, ... }:

_final: prev: {
  fishPlugins = prev.fishPlugins // {
    inherit (channels.unstable) bang-bang;
  };
}
