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

  cfg = config.${namespace}.editors.emacs.packages.treemacs;
in
{
  options.${namespace}.editors.emacs.packages.treemacs = {
    enable = mkBoolOpt false "Whether or not to enable the emacs treemacs package.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ python3 ];

    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.treemacs ]);
      extraConfig = ''
        (use-package treemacs
          :bind (("M-²" . treemacs-select-window)
                 ("M-0" . treemacs-select-window)))
      '';
    };
  };
}
