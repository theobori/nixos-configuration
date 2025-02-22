{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf mkBefore;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode = {
    enable = mkBoolOpt false "Whether or not to enable the emacs lsp-mode package.";
  };

  config = mkIf cfg.enable {
    ${namespace}.editors.emacs.packages.ivy = enabled;

    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.lsp-mode
          epkgs.lsp-ivy
          epkgs.yasnippet
          epkgs.company
          epkgs.lsp-ui
        ]
      );
      extraConfig = mkBefore ''
        (require 'yasnippet)
        (yas-reload-all)
        (add-hook 'prog-mode-hook #'yas-minor-mode)

        ;; Using use-package is a better pratice, but for the moment, I could not make it work.
        (require 'lsp-mode)

        (use-package lsp-ivy :ensure t :commands lsp-ivy-workspace-symbol)
        (use-package lsp-ui :ensure t :commands lsp-ui-mode)

        (setq lsp-headerline-breadcrumb-icons-enable nil)
      '';
    };
  };
}
