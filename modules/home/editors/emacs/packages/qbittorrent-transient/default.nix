{
  inputs,
  config,
  lib,
  namespace,
  system,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.qbittorrent-transient;
in
{
  options.${namespace}.editors.emacs.packages.qbittorrent-transient = {
    enable = mkBoolOpt false "Whether or not to enable the emacs qbittorrent-transient package.";
  };

  config = mkIf cfg.enable {
    ${namespace}.programs.qbittorrent.enable = true;

    programs.emacs = {
      extraPackages = (
        _epkgs: [
          inputs.qbittorrent-transient.packages.${system}.default
        ]
      );
      extraConfig = "(use-package qbittorrent-transient)";
    };
  };
}
