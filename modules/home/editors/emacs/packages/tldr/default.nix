{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.tldr;
in
{
  options.${namespace}.editors.emacs.packages.tldr = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Tldr package.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ unzip ];
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.tldr ]);
      extraConfig = ''
        (use-package tldr)
      '';
    };
  };
}
