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
        ]
      );
      extraConfig = ''
                (use-package vertico
          :ensure t
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
          :after vertico
          :ensure t
          :custom
          (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
          :init
          (marginalia-mode))
      '';
    };
  };
}
