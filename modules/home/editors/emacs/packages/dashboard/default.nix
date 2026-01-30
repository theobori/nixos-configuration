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
          (dashboard-startup-banner '("${./04_padman.png}" . "${./04_padman.txt}"))
          (dashboard-banner-logo-title "I'm the King, I'm PADMAN.")
          (dashboard-center-content t)
          (dashboard-set-navigator t)
          (dashboard-icon-type 'all-the-icons)
          (dashboard-items '((projects . 5)
                          (recents  . 5)
                          (agenda . 5)))
          (dashboard-set-file-icons t)
          (dashboard-projects-backend 'project-el)
          (dashboard-footer-messages '("Don't run, Don't jump, only hold still. It's better for me to frag you.."
                                       "Quit crying Freak, you were born as a loser..hehe"
                                       "do that again, bitch."
                                       "I bet you have to put a lot of effort into being that stupid."
                                       "Wow, is that my brain on the wall..?"
                                       "That wasn't luck, I just went easy on you."
                                       "Nobody can stop me."
                                       "Okay, here is PADMAN and it's time to frag you..!"
                                       "Oh, PADGiRL is looking for me, she wants to go to bed..!"))

          :config
          (setq initial-buffer-choice (lambda ()
                                      (get-buffer-create "*dashboard*")
                                      (dashboard-refresh-buffer))))
      '';
    };
  };
}
