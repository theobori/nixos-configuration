{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.dracula-theme;
in
{
  options.${namespace}.editors.emacs.packages.dracula-theme = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Dracula-Theme package.";
  };

  config = mkIf cfg.enable {
    stylix.targets.emacs.enable = false;
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.dracula-theme ]);
      extraConfig = ''
        (load-theme 'dracula t)
      '';
    };
  };
}
