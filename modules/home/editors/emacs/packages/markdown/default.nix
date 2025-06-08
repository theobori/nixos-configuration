{
  config,
  lib,
  namespace,
  pkgs,
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
    home.packages = with pkgs; [ pandoc ];

    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.markdown-mode ]);
      extraConfig = ''
        (use-package markdown-mode
          :commands (markdown-mode gfm-mode)
          :mode (("README\\.md\\'" . gfm-mode)
                 ("\\.md\\'" . markdown-mode)
                 ("\\.markdown\\'" . markdown-mode)
                 ("\\.mdx\\'" . markdown-mode))
          :custom
          (markdown-command "pandoc"))
      '';
    };
  };
}
