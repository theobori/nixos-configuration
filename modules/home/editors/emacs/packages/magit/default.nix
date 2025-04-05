{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.magit;
in
{
  options.${namespace}.editors.emacs.packages.magit = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Magit package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.magit ]);
      extraConfig = ''
        (use-package magit
          :commands magit-status
          :bind
          ("C-x g" . magit-status))
      '';
    };
  };
}
