{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.yaml;
in
{
  options.${namespace}.editors.emacs.packages.yaml = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Yaml package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.yaml-mode ]);
      extraConfig = ''
        (use-package yaml-mode
          :commands (markdown-mode gfm-mode)
          :mode (("\\.yml\\'" . yaml-mode)
                 ("\\.yaml\\'" . yaml-mode)))
      '';
    };
  };
}
