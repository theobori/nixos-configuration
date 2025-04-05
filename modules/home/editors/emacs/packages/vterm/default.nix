{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.vterm;
in
{
  options.${namespace}.editors.emacs.packages.vterm = {
    enable = mkBoolOpt false "Whether or not to enable the emacs vterm package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.vterm ]);
      extraConfig = ''
        (use-package vterm
          :commands vterm
          :custom
          (term-prompt-regexp "^[^#$%>\n]*[#$%>] *")
          (vterm-shell "fish")
          (vterm-max-scrollback 10000))
      '';
    };
  };
}
