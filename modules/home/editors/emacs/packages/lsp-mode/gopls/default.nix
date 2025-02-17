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

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.gopls;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.gopls = {
    enable = mkBoolOpt false "Whether or not to enable gopls for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [ gopls ];

    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.go-mode ]);

      extraConfig = ''
        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(go-mode . "go"))

          (lsp-register-client (make-lsp-client
            :new-connection (lsp-stdio-connection "gopls")
            :activation-fn (lsp-activate-on "go")
            :server-id 'gopls))

          (add-hook 'go-mode-hook #'lsp))
      '';
    };
  };
}
