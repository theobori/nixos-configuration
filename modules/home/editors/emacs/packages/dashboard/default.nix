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
          :after (all-the-icons)
          :init (dashboard-setup-startup-hook)
          :if (or (display-graphic-p) (and (not (daemonp))
                      (= (length command-line-args) 1)))
          :custom
          (dashboard-startup-banner 'logo)
          (dashboard-center-content t)
          (dashboard-set-navigator t)
          (dashboard-icon-type 'all-the-icons)
          (dashboard-items '((projects . 5)
                          (recents  . 5)
                          (agenda . 5)))
          (dashboard-set-file-icons t)
          (dashboard-projects-backend 'project-el)
          :config
          (setq initial-buffer-choice (lambda ()
                                      (get-buffer-create "*dashboard*")
                                      (dashboard-refresh-buffer))))
      '';
    };
  };
}
