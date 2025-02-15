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

  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.nixd;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.nixd = {
    enable = mkBoolOpt false "Whether or not to enable nixd for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [
      nixd
      nixfmt-rfc-style
    ];

    programs.emacs = {
      extraPackages = (
        epkgs: [
          epkgs.company
          epkgs.nix-mode
        ]
      );

      extraConfig = ''
                (use-package nix-mode
        :after lsp-mode
        :ensure t
        :hook
        (nix-mode . lsp-deferred) ;; So that envrc mode will work
        :mode "\\.nix\\'"
        :config
        (setq lsp-nix-nixd-server-path "nixd"
              lsp-nix-nixd-formatting-command [ "nixfmt" ]
              lsp-nix-nixd-nixpkgs-expr "import <nixpkgs> { }"
              ))

        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))

          (lsp-register-client (make-lsp-client
            :new-connection (lsp-stdio-connection "nixd")
            :activation-fn (lsp-activate-on "nix")
            :priority 0
            :server-id 'nixd))

          (add-hook 'nix-mode-hook #'lsp)
          )
      '';
    };
  };
}
