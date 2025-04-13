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
          epkgs.company-box
          epkgs.lsp-ui
          epkgs.lsp-treemacs
        ]
      );
      extraConfig = mkBefore ''
        (use-package company
          :config
          (global-company-mode)
          :custom
          (company-idle-delay 0)
          (company-echo-delay 0)
          (company-minimum-prefix-length 1))

        (use-package company-box
          :after company
          :if (display-graphic-p)
          :custom
          (company-box-frame-behavior 'point)
          (company-box-show-single-candidate t)
          (company-box-doc-delay 1))

        (use-package yasnippet
          :diminish yas-minor-mode
          :demand t
          :hook
          ((prog-mode . yas-minor-mode))
          :config
          (yas-reload-all))

        (declare-function yas-reload-all  "yasnippet")

        (use-package lsp-mode
          :hook
          ((sh-mode . lsp))
          :commands lsp
          :custom
          (lsp-headerline-breadcrumb-icons-enable nil))

        (use-package lsp-ivy
          :after lsp-mode
          :commands lsp-ivy-workspace-symbol)

        (use-package lsp-ui
          :after lsp-mode
          :commands lsp-ui-mode)

        (use-package lsp-treemacs
          :config
          (lsp-treemacs-sync-mode 1))
      '';
    };
  };
}
