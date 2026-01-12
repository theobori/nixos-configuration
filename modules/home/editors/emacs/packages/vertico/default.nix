{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.vertico;
in
{
  options.${namespace}.editors.emacs.packages.vertico = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Vertico package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.vertico
          epkgs.marginalia
          epkgs.all-the-icons
          epkgs.all-the-icons-completion
        ]
      );
      extraConfig = ''
        (use-package vertico
          :bind (:map vertico-map
                 ("C-j" . vertico-next)
                 ("C-k" . vertico-previous)
                 ("C-f" . vertico-exit)
                 :map minibuffer-local-map
                 ("M-h" . backward-kill-word))
          :custom
          (vertico-cycle t)
          :init
          (vertico-mode))

        (use-package savehist
          :init
          (savehist-mode))

        (use-package marginalia
          ;; :after vertico
          ;; :custom
          ;; (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
          :init
          (marginalia-mode))

        (use-package all-the-icons
          :if (display-graphic-p))

        (use-package all-the-icons-completion
          :after (marginalia all-the-icons)
          :hook (marginalia-mode . all-the-icons-completion-marginalia-setup)
          :init
          (all-the-icons-completion-mode))

        ;; Emacs minibuffer configurations.
        (use-package emacs
          :custom
          ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
          ;; to switch display modes.
          (context-menu-mode t)
          ;; Support opening new minibuffers from inside existing minibuffers.
          (enable-recursive-minibuffers t)
          ;; Hide commands in M-x which do not work in the current mode.  Vertico
          ;; commands are hidden in normal buffers. This setting is useful beyond
          ;; Vertico.
          (read-extended-command-predicate #'command-completion-default-include-p)
          ;; Do not allow the cursor in the minibuffer prompt
          (minibuffer-prompt-properties
           '(read-only t cursor-intangible t face minibuffer-prompt)))
      '';
    };
  };
}
