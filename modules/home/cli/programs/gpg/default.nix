{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.cli.programs.gpg;
in
{
  options.${namespace}.cli.programs.gpg = {
    enable = mkBoolOpt false "Whether or not to enable gpg.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kleopatra ];

    programs = {
      gpg = {
        enable = true;
      };
    };
  };
}
