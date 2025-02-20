{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;
  cfg = config.${namespace}.editors.emacs.packages.dashboard;
in
{
  options.${namespace}.editors.emacs.packages.dashboard = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Dashboard package.";
  };
  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.dashboard ]);
      extraConfig = ''
        (use-package dashboard
          :ensure t
          :config
          (when (and (not (daemonp))
                    (not window-system)
                    (= (length command-line-args) 1))
            (dashboard-setup-startup-hook)
            (setq dashboard-startup-banner 'official
                  dashboard-center-content t
                  dashboard-items '((projects . 5)
                                  (recents  . 5)))
            (setq dashboard-set-footer nil)
            (setq dashboard-banner-logo-title "This is your life")
            (setq dashboard-set-file-icons t)
            (setq dashboard-projects-backend 'project-el)
            (setq initial-buffer-choice (lambda ()
                                        (get-buffer-create "*dashboard*")
                                        (dashboard-refresh-buffer)))))
      '';
    };
  };
}
