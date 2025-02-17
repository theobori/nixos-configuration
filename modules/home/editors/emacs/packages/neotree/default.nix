{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.neotree;
in
{
  options.${namespace}.editors.emacs.packages.neotree = {
    enable = mkBoolOpt false "Whether or not to enable the emacs neotree package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.neotree ]);
      extraConfig = ''
        (use-package neotree
          :bind (("<f8>" . neotree-toggle)
        	)
          :ensure t
        )
      '';
    };
  };
}
