{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.terraform;
in
{
  options.${namespace}.editors.emacs.packages.terraform = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Terraform package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.terraform-mode ]);
      extraConfig = ''
        (use-package terraform-mode
          :hook ((terraform-mode . lsp-deferred)
                 (terraform-mode . terraform-format-on-save-mode))
          :mode "\\.tf\\'")
      '';
    };
  };
}
