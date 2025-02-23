{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.org-download;
in
{
  options.${namespace}.editors.emacs.packages.org-download = {
    enable = mkBoolOpt false "Whether or not to enable the emacs org-download package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.org-download ]);
      extraConfig = ''
        (use-package org-download
          :ensure t
          :config
            (add-hook 'dired-mode-hook 'org-download-enable)
            (setq-default
              org-download-method 'directory
              org-download-image-dir "Attachments"
              org-download-heading-lvl nil))
      '';
    };
  };
}
