{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.ivy;
in
{
  options.${namespace}.editors.emacs.packages.ivy = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Ivy package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.ivy
          epkgs.ivy-rich
          epkgs.all-the-icons-ivy
          epkgs.counsel
        ]
      );
      extraConfig = ''
        (use-package counsel
          :demand t
          :bind (("M-x" . counsel-M-x)
                 ("C-x b" . counsel-ibuffer)
                 ("C-x C-f" . counsel-find-file)
                 ("C-M-j" . counsel-switch-buffer)
          :map minibuffer-local-map
          ("C-r" . 'counsel-minibuffer-history))
          :custom
          (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
          :config
          (setq ivy-initial-inputs-alist nil))

        (use-package ivy
          :commands ivy-mode
          :init
          (ivy-mode 1)
          :custom
          (ivy-height 10)
          (ivy-fixed-height-minibuffer t)
          :bind (("C-x b" . ivy-switch-buffer)
                 ("C-c r" . ivy-resume)
                 ("C-x C-b" . ibuffer))
          :config
          (setq enable-recursive-minibuffers t))

        (use-package ivy-rich
          :init (ivy-rich-mode 1))

        (use-package all-the-icons-ivy
          :hook
          ((after-init . all-the-icons-ivy-setup)))
      '';
    };
  };
}
