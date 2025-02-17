{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.editors.emacs.packages.obsidian;
in
{
  options.${namespace}.editors.emacs.packages.obsidian = with types; {
    enable = mkBoolOpt false "Whether or not to enable the emacs obsidian package.";
    path = mkOpt str "~/Documents/theo" "Whether or not to enable the emacs obsidian package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.obsidian ]);
      extraConfig = ''
            (use-package obsidian
        :ensure t
        :demand t
        :config
        (obsidian-specify-path "${cfg.path}")
        (global-obsidian-mode t)
        :custom
        ;; This directory will be used for `obsidian-capture' if set.
        (obsidian-inbox-directory "Inbox")
        ;; t: in inbox, nil: next to the file with the link
        ;; default: t
        ;(obsidian-wiki-link-create-file-in-inbox nil)
        ;; The directory for daily notes (file name is YYYY-MM-DD.md)
        (obsidian-daily-notes-directory "Daily Notes")
        ;; Directory of note templates, unset (nil) by default
        ;(obsidian-templates-directory "Templates")
        ;; Daily Note template name - requires a template directory. Default: Daily Note Template.md
        ;(obsidian-daily-note-template "Daily Note Template.md")
        :bind (:map obsidian-mode-map
        ;; Replace C-c C-o with Obsidian.el's implementation. It's ok to use another key binding.
        ("C-c C-o" . obsidian-follow-link-at-point)
        ;; Jump to backlinks
        ("C-c C-b" . obsidian-backlink-jump)
        ;; If you prefer you can use `obsidian-insert-link'
        ("C-c C-l" . obsidian-insert-wikilink)))
      '';
    };
  };
}
