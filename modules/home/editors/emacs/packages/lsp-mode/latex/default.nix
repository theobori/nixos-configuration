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

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.latex;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.latex = {
    enable = mkBoolOpt false "Whether or not to enable latex for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [ lua54Packages.digestif ];

    programs.emacs = {
      extraConfig = ''
        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(tex-mode . "tex"))

          (lsp-register-client (make-lsp-client
            :new-connection (lsp-stdio-connection "digestif")
            :activation-fn (lsp-activate-on "tex")
            :server-id 'tex))

          (add-hook 'tex-mode-hook #'lsp))
      '';
    };
  };
}
