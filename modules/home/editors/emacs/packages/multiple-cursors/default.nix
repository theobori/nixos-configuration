{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.multiple-cursors;
in
{
  options.${namespace}.editors.emacs.packages.multiple-cursors = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Multiple-Cursors package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.multiple-cursors ]);
      extraConfig = ''
        (use-package multiple-cursors
          :bind (("C-S-c C-S-c" . mc/edit-lines)
                 ("C->" . mc/mark-next-like-this)
                 ("C-<" . mc/mark-previous-like-this)
                 ("C-c C-<" . mc/mark-all-like-this)))
      '';
    };
  };
}
