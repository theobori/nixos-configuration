{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.org-superstar;
in
{
  options.${namespace}.editors.emacs.packages.org-superstar = {
    enable = mkBoolOpt false "Whether or not to enable the emacs org-superstar package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.org-superstar ]);
      extraConfig = ''
        (use-package org-superstar
          :after org
          :hook (org-mode . org-superstar-mode)
          :custom
          (org-superstar-remove-leading-stars t)
          (org-superstar-headline-bullets-list '("⁖" "✿" "▷" "✸")))
      '';
    };
  };
}
