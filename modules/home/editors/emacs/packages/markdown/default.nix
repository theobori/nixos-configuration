{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.markdown;
in
{
  options.${namespace}.editors.emacs.packages.markdown = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Markdown package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.markdown-mode ]);
      extraConfig = ''
        (use-package markdown-mode
          :ensure t
          :commands (markdown-mode gfm-mode)
          :mode (("README\\.md\\'" . gfm-mode)
            ("\\.md\\'" . markdown-mode)
            ("\\.markdown\\'" . markdown-mode))
          :init (setq markdown-command "pandoc"))

        (add-to-list 'auto-mode-alist '("\\.mdx\\'" . markdown-mode))
      '';
    };
  };
}
