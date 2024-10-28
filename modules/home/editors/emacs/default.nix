{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.editors.emacs;
in
{
  options.editors.emacs = {
    enable = lib.mkEnableOption "Whether or not to enable emacs";
  };

  config = lib.mkIf cfg.enable {
    programs.emacs = {
      enable = true;

      package = pkgs.emacs-nox;
    };
  };
}
