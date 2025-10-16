{
  lib,
  config,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.services.xremap;
in
{
  options.${namespace}.services.xremap = {
    enable = mkBoolOpt false "Enable X remapping using xremap.";
  };

  config = mkIf cfg.enable {
    services.xremap = {
      enable = true;
      withX11 = true;
      config.modmap = [
        {
          name = "CapsLock to Control";
          remap = {
            "CapsLock" = "Ctrl_L";
          };
        }
      ];
    };
  };
}
