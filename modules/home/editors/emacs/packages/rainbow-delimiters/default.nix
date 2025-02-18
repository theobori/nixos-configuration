{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.rainbow-delimiters;
in
{
  options.${namespace}.editors.emacs.packages.rainbow-delimiters = {
    enable = mkBoolOpt false "Whether or not to enable the emacs rainbow-delimiters package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.rainbow-delimiters ]);
      extraConfig = ''
        (use-package rainbow-delimiters
          :ensure t
          :hook (prog-mode . rainbow-delimiters-mode))
      '';
    };
  };
}
