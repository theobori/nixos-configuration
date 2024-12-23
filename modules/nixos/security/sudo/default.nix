{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.security.sudo;
in
{
  options.${namespace}.security.sudo = {
    enable = mkBoolOpt false "Whether or not to replace sudo with sudo.";
  };

  config = mkIf cfg.enable { security.sudo = enabled; };
}
