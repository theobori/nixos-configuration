{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.all-the-icons-ibuffer;
in
{
  options.${namespace}.editors.emacs.packages.all-the-icons-ibuffer = {
    enable = mkBoolOpt false "Whether or not to enable the emacs All-The-Icons-Ibuffer package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.all-the-icons-ibuffer ]);
      extraConfig = ''
        (use-package all-the-icons-ibuffer
          :hook (ibuffer-mode . all-the-icons-ibuffer-mode))
      '';
    };
  };
}
