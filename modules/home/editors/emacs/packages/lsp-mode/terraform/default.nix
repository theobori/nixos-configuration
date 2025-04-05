{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled;

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.terraform;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.terraform = {
    enable = mkBoolOpt false "Whether or not to enable terraform for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [ terraform-ls ];

    # Provide the Terraform GNU Emacs mode
    ${namespace}.editors.emacs.packages.terraform = enabled;

    programs.emacs = {
      extraConfig = ''
        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(terraform-mode . "terraform"))

          (lsp-register-client
           (make-lsp-client :new-connection (lsp-stdio-connection '("terraform-ls" "serve"))
                            :major-modes '(terraform-mode)
                            :server-id 'terraform-ls)))
      '';
    };
  };
}
