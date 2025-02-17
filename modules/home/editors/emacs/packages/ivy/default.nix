{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.ivy;
in
{
  options.${namespace}.editors.emacs.packages.ivy = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Ivy package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.ivy ]);
      extraConfig = ''
        (use-package ivy
          :ensure t
          :commands
          ivy-mode
          :init
          (ivy-mode 1)
          (setq ivy-height 10
                ivy-fixed-height-minibuffer t)
          :bind (("C-x b" . ivy-switch-buffer)
                 ("C-c r" . ivy-resume)
        	 ("C-x C-b" . ibuffer)))
      '';
    };
  };
}
