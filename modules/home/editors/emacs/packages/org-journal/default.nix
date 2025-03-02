{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.org-journal;
in
{
  options.${namespace}.editors.emacs.packages.org-journal = {
    enable = mkBoolOpt false "Whether or not to enable the emacs org-journal package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.org-journal ]);
      extraConfig = ''
        (use-package org-journal
          :ensure t
          :defer t
          :init
            (setq org-journal-prefix-key "C-c j ")
          :config
            (setq org-journal-dir "~/org/journal/"
                  org-journal-date-format "%A, %d %B %Y"))
      '';
    };
  };
}
