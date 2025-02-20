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

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.bash-language-server;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.bash-language-server = {
    enable = mkBoolOpt false "Whether or not to enable bash-language-server for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [ bash-language-server ];

    programs.emacs = {
      extraConfig = ''
        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(sh-mode . "bash"))

          (lsp-register-client (make-lsp-client
            :new-connection (lsp-stdio-connection '("bash-language-server" "start"))
            :activation-fn (lsp-activate-on "bash")
            :server-id 'bash-language-server))

          (add-hook 'sh-mode-hook #'lsp))
      '';
    };
  };
}
