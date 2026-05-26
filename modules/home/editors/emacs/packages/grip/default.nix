{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.grip;
in
{
  options.${namespace}.editors.emacs.packages.grip = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Grip package.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ go-grip ];

    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.grip-mode ]);
      extraConfig = ''
        (use-package grip-mode
          :config (setq grip-command 'go-grip)
          :bind (:map markdown-mode-command-map
                 ("g" . grip-mode)))
      '';
    };
  };
}
