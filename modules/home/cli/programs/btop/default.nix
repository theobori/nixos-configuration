{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.btop;
in
{
  options.${namespace}.cli.programs.btop = {
    enable = mkBoolOpt false "Whether or not to enable btop.";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;

      extraConfig = ''
        proc_left = False
      '';
    };
  };
}
