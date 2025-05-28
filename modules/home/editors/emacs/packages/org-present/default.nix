{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.org-present;
in
{
  options.${namespace}.editors.emacs.packages.org-present = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Org-Present package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.org-present
          epkgs.visual-fill-column
        ]
      );
      extraConfig = ''
        (use-package visual-fill-column
          :custom
          (visual-fill-column-width 110)
          (visual-fill-column-center-text t))

        (defun my/org-present-start ()
          ;; Show images within the buffer
          (org-display-inline-images)

          ;; Center the text
          (visual-fill-column-mode 1)
          (visual-line-mode 1))

        (defun my/org-present-end ()
          ;; Hide images
          (org-remove-inline-images)

          ;; Cancel the text centering
          (visual-fill-column-mode 0)
          (visual-line-mode 0))

        (use-package org-present
          :after (org visual-fill-column)
          :hook
          ((org-present-mode . my/org-present-start)
          (org-present-mode-quit . my/org-present-end)))
      '';
    };
  };
}
