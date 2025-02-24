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
        (setq visual-fill-column-width 110
              visual-fill-column-center-text t)

        (defun my/org-present-start ()
          (setq
            display-line-numbers-old display-line-numbers
            display-line-numbers nil)

          (visual-fill-column-mode 1)
          (visual-line-mode 1))

        (defun my/org-present-end ()
          (setq display-line-numbers display-line-numbers-old)

          (visual-fill-column-mode 0)
          (visual-line-mode 0))

        (add-hook 'org-present-mode-hook 'my/org-present-start)
        (add-hook 'org-present-mode-quit-hook 'my/org-present-end)
      '';
    };
  };
}
