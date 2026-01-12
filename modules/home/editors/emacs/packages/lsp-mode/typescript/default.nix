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

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.typescript;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.typescript = {
    enable = mkBoolOpt false "Whether or not to enable typescript for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [
      typescript
      typescript-language-server
    ];

    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.typescript-mode ]);
      extraConfig = ''
        (use-package typescript-mode
           :hook
           (typescript-mode . lsp-deferred) ;; So that envrc mode will work
           :mode "\\.ts?$")

        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(typescript-mode . "typescript"))

          (lsp-register-client (make-lsp-client
            :new-connection (lsp-stdio-connection "typescript")
            :activation-fn (lsp-activate-on "typescript")
            :server-id 'typescript))

          (add-hook 'typescript-mode-hook #'lsp))
      '';
    };
  };
}
