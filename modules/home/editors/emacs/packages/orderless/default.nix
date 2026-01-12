{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.orderless;
in
{
  options.${namespace}.editors.emacs.packages.orderless = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Orderless package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.orderless ]);
      extraConfig = ''
        ;; Optionally use the `orderless' completion style.
        (use-package orderless
          :custom
          ;; Configure a custom style dispatcher (see the Consult wiki)
          ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
          ;; (orderless-component-separator #'orderless-escapable-split-on-space)
          (completion-styles '(orderless basic))
          (completion-category-overrides '((file (styles partial-completion))))
          (completion-category-defaults nil) ;; Disable defaults, use our settings
          (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring
      '';
    };
  };
}
