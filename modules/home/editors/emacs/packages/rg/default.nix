{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.rg;
in
{
  options.${namespace}.editors.emacs.packages.rg = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Rg package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.rg ]);
      extraConfig = ''
        (require 'rg)
      '';
    };
  };
}
