{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.messages.ayugram;
in
{
  options.${namespace}.messages.ayugram = {
    enable = mkBoolOpt false "Enable AyuGram.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ ayugram-desktop ];
  };
}
