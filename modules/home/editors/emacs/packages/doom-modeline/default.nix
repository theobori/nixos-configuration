{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.doom-modeline;
in
{
  options.${namespace}.editors.emacs.packages.doom-modeline = {
    enable = mkBoolOpt false "Whether or not to enable the emacs doom-modeline package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.doom-modeline
          epkgs.all-the-icons
        ]
      );
      extraConfig = ''
        (use-package all-the-icons)
        (use-package doom-modeline
          :init (doom-modeline-mode 1))
      '';
    };
  };
}
