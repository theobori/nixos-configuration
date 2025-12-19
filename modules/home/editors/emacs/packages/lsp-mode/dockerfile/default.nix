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
  cfg = config.${namespace}.editors.emacs.packages.lsp-mode.dockerfile;
  lsp-mode = config.${namespace}.editors.emacs.packages.lsp-mode;
in
{
  options.${namespace}.editors.emacs.packages.lsp-mode.dockerfile = {
    enable = mkBoolOpt false "Whether or not to enable dockerfile for lsp-mode (Emacs).";
  };

  config = mkIf (lsp-mode.enable && cfg.enable) {
    home.packages = with pkgs; [ dockerfile-language-server ];

    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.dockerfile-mode ]);
      extraConfig = ''
         (use-package dockerfile-mode
           :hook
           (nix-mode . lsp-deferred) ;; So that envrc mode will work
           :mode "\\Dockerfile?$"
           :config
           (put 'dockerfile-image-name 'safe-local-variable #'stringp))

        (with-eval-after-load 'lsp-mode
          (add-to-list 'lsp-language-id-configuration '(dockerfile-mode . "dockerfile"))

          (lsp-register-client (make-lsp-client
            :new-connection (lsp-stdio-connection '("docker-langserver" "--stdio"))
            :priority 0
            :server-id 'dockerfile))

          (add-hook 'dockerfile-mode-hook #'lsp))
      '';
    };
  };
}
