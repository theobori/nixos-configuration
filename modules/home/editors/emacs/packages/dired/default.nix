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
          epkgs.dired-ranger
          epkgs.dired-collapse
        ]
      );
      extraConfig = ''
        (use-package all-the-icons-dired)
        (use-package dired
          :ensure nil
          :straight nil
          :defer 1
          :commands (dired dired-jump)
          :config
            (setq dired-listing-switches "-agho --group-directories-first")
            (setq dired-omit-files "^\\.[^.].*")
            (setq dired-omit-verbose nil)
            (setq dired-hide-details-hide-symlink-targets nil)
            (put 'dired-find-alternate-file 'disabled nil)
            (setq delete-by-moving-to-trash t)
            (autoload 'dired-omit-mode "dired-x")
            (add-hook 'dired-load-hook
                  (lambda ()
                    (interactive)
                    (dired-collapse)))
            (add-hook 'dired-mode-hook
                  (lambda ()
                    (interactive)
                    (dired-omit-mode 1)
                    (dired-hide-details-mode 1)
                    (all-the-icons-dired-mode 1))
                    (hl-line-mode 1)))

        (use-package dired-ranger)
        (use-package dired-collapse)        
      '';
    };
  };
}
