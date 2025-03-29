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
      extraPackages = (
        epkgs: [
          epkgs.dashboard
          epkgs.all-the-icons
        ]
      );
      extraConfig = ''
        (use-package dashboard
          :ensure t
          :after (all-the-icons)
          :config
          (when (or (display-graphic-p) (and (not (daemonp))
                    (= (length command-line-args) 1)))
            (dashboard-setup-startup-hook)
            (setq dashboard-startup-banner 'logo
                  dashboard-center-content t
                  dashboard-set-navigator t
                  dashboard-icon-type 'all-the-icons
                  dashboard-items '((projects . 5)
                                  (recents  . 5)))
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
