{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.pdf-tools;
in
{
  options.${namespace}.editors.emacs.packages.pdf-tools = {
    enable = mkBoolOpt false "Whether or not to enable the emacs pdf-tools package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.pdf-tools ]);
      extraConfig = ''
        (use-package pdf-tools
          :config
          (pdf-tools-install))
      '';
    };
  };
}
