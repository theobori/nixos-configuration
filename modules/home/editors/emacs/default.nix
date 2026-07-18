{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.editors.emacs;
in
{
  options.${namespace}.editors.emacs = with types; {
    enable = mkBoolOpt false "Whether or not to enable emacs.";
    package = mkOpt package pkgs.emacs "Whether or not to enable emacs.";

    extraConfig = mkOpt str ''
      (global-auto-revert-mode 1)
      (show-paren-mode t)
      (setq use-short-answers t
            show-trailing-whitespace t)

      ;; Remove the menu bar
      (menu-bar-mode -1)

      (when (display-graphic-p)
        ;; Resize small font on the GUI Emacs application
        (set-face-attribute 'default nil :height 105)

        ;; Annoying displayed UI elements
        (tool-bar-mode -1)
        (scroll-bar-mode -1))

      (setq display-line-numbers-type 'relative)
      (setq standard-indent 2)
      (add-hook 'prog-mode-hook 'display-line-numbers-mode)

      ;; Needed to request GPG passphrase with Emacs
      (setq epg-pinentry-mode 'loopback)

      ;; Disable the ring bell sound
      (setq ring-bell-function 'ignore)

      ;; See https://snarfed.org/gnu_emacs_backup_files
      (custom-set-variables
        '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
        '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

      (make-directory "~/.emacs.d/autosaves/" t)

      (setq org-link-file-path-type 'relative)

      ;; See https://themkat.net/2025/03/25/simple_smoother_emacs_scrolling.html
      (setq scroll-conservatively 10
        scroll-margin 15)

      (setq inhibit-startup-screen t)

      ;; Better and cool behaviors
      (electric-pair-mode 1)
      (global-hl-line-mode 1)
      (delete-selection-mode 1)

      ;; Run Emacs server
      (use-package server :ensure nil)
      (unless (server-running-p)
        (server-start))
    '' "Emacs extra configuration.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      inherit (cfg) package extraConfig;
    };

    services.emacs = {
      enable = true;
      startWithUserSession = true;
    };
  };
}
