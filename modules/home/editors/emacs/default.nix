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
      (defalias 'yes-or-no-p 'y-or-n-p)

      (menu-bar-mode -1)
      (global-display-line-numbers-mode)
      (setq standard-indent 2)
      (setq font-lock-maximum-decoration t)
      (setq display-line-numbers-type 'relative)

      ;; See https://snarfed.org/gnu_emacs_backup_files
      (custom-set-variables
        '(auto-save-file-name-transforms '((".*" "~/.emacs.d/autosaves/\\1" t)))
        '(backup-directory-alist '((".*" . "~/.emacs.d/backups/"))))

      (make-directory "~/.emacs.d/autosaves/" t)

      (setq org-link-file-path-type 'relative)
    '' "Emacs extra configuration.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      enable = true;
      inherit (cfg) package extraConfig;
    };
  };
}
