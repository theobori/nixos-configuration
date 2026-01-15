{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.org;
in
{
  options.${namespace}.editors.emacs.packages.org = {
    enable = mkBoolOpt false "Whether or not to enable the emacs org package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraConfig = ''
        (use-package org
          :ensure nil
          :custom
          (org-startup-with-inline-images t)
          (org-startup-folded t)
          (org-todo-keyword-faces '(("DONE" . "GREEN")))
          (org-hide-emphasis-markers t)
          (org-image-actual-width nil)
          (org-support-shift-select t)
          (org-pretty-entities t)
          (org-agenda-files '("~/.emacs-org-agenda")))
      '';
    };
  };
}
