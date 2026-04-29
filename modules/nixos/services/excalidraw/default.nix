{
  lib,
  config,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.strings) hasPrefix hasInfix hasSuffix;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.services.excalidraw;
in
{
  options.${namespace}.services.excalidraw = with types; {
    enable = mkBoolOpt false "Enable excalidraw local instance.";
    domain-name = mkOpt str "excalidraw.local" "Excalidraw domain name";
  };

  config = mkIf cfg.enable {
    assertions = [
      {
        assertion =
          !(hasPrefix "." cfg.domain-name)
          && !(hasSuffix "." cfg.domain-name)
          && (hasInfix "." cfg.domain-name);
        message = "The domain name should at least contain two levels";
      }
    ];

    services.nginx = {
      enable = true;
      virtualHosts."${cfg.domain-name}" = {
        locations."/" = {
          root = pkgs.${namespace}.excalidraw;
        };
      };
    };

    networking.extraHosts = ''
      127.0.0.1 ${cfg.domain-name}
    '';
  };
}
