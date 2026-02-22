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

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.ccls;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.ccls = {
    enable = mkBoolOpt false "Whether or not to enable ccls for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [ ccls ];

    programs.emacs = {
      extraConfig = ''
        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(c-mode . "c"))
          (add-to-list 'lsp-language-id-configuration '(c++-mode . "c"))
          (add-to-list 'lsp-language-id-configuration '(objc-mode . "c"))

          (lsp-register-client (make-lsp-client
                                :new-connection (lsp-stdio-connection "ccls")
                                :activation-fn (lsp-activate-on "c")
                                :server-id 'ccls))

          (add-hook 'c-mode-hook #'lsp)
          (add-hook 'c++-mode-hook #'lsp)
          (add-hook 'objc-mode-hook #'lsp))
      '';
    };
  };
}
