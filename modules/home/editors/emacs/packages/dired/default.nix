{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.dired;
in
{
  options.${namespace}.editors.emacs.packages.dired = {
    enable = mkBoolOpt false "Whether or not to enable the emacs dired package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.all-the-icons-dired
          epkgs.dired-collapse
        ]
      );
      extraConfig = ''
        (use-package all-the-icons-dired :ensure t)
        (use-package dired
          :ensure nil
          :defer 1
          :commands (dired dired-jump)
          :config
            (setq dired-kill-when-opening-new-dired-buffer t) ;; It prevents having hundreds useless buffers
            (add-hook 'dired-load-hook
                  (lambda ()
                    (interactive)
                    (dired-collapse)))
            (add-hook 'dired-mode-hook
                  (lambda ()
                    (interactive)
                    (all-the-icons-dired-mode 1))
                    (hl-line-mode 1)))

        (use-package dired-collapse :ensure t)
      '';
    };
  };
}
