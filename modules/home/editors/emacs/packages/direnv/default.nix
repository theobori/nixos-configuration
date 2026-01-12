{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.direnv;
in
{
  options.${namespace}.editors.emacs.packages.direnv = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Direnv package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.direnv ]);
      extraConfig = ''
        (use-package direnv
          :config
          (direnv-mode))
      '';
    };
  };
}
