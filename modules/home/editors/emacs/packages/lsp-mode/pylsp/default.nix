{
  config,
  lib,
  namespace,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf mkAfter;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.pylsp;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.pylsp = {
    enable = mkBoolOpt false "Whether or not to enable pylsp for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [ python3Packages.python-lsp-server ];

    programs.emacs = {
      extraConfig = mkAfter ''
        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(python-mode . "python"))

          (lsp-register-client (make-lsp-client
            :new-connection (lsp-stdio-connection "pylsp")
            :activation-fn (lsp-activate-on "python")
            :server-id 'pylsp)))

        (add-hook 'python-mode-hook #'lsp)
      '';
    };
  };
}
