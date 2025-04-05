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

  cfg = config.${namespace}.editors.emacs.packages.auto-save;
in
{
  options.${namespace}.editors.emacs.packages.auto-save = {
    enable = mkBoolOpt false "Whether or not to enable the emacs auto-save package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (_epkgs: [ pkgs.${namespace}.auto-save ]);
      extraConfig = ''
        (use-package auto-save
          :config
          (auto-save-enable)
          :custom
          (auto-save-silent t)
          (auto-save-delete-trailing-whitespace t)
          (auto-save-disable-predicates
          '((lambda ()
              (string-suffix-p
               "gpg"
               (file-name-extension (buffer-name)) t)))))
        (declare-function auto-save-enable "auto-save")
      '';
    };
  };
}
