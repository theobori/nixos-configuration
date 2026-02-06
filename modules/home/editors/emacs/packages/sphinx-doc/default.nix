{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.sphinx-doc;
in
{
  options.${namespace}.editors.emacs.packages.sphinx-doc = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Sphinx-Doc package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.sphinx-doc ]);
      extraConfig = ''
        (use-package sphinx-doc
          :hook
          (python-mode . sphinx-doc-mode)
          :custom
          (sphinx-doc-include-types t))
      '';
    };
  };
}
