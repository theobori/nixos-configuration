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
          :hook
          ((dired-mode . org-download-enable))
          :custom
          (org-download-method 'directory)
          (org-download-image-dir "Attachments")
          (org-download-heading-lvl nil))
      '';
    };
  };
}
