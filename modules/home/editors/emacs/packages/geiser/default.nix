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

  cfg = config.${namespace}.editors.emacs.packages.geiser;
in
{
  options.${namespace}.editors.emacs.packages.geiser = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Geiser package.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ guile ];
    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.geiser
          epkgs.geiser-guile
        ]
      );
      extraConfig = ''
        (use-package geiser)
      '';
    };
  };
}
