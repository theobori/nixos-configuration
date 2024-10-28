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

  cfg = config.${namespace}.editors.emacs;
in
{
  options.${namespace}.editors.emacs = {
    enable = mkBoolOpt false "Whether or not to enable emacs.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;

      package = pkgs.emacs-nox;
    };
  };
}
