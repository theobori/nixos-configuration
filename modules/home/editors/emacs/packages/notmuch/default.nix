{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.notmuch;
  email = config.${namespace}.accounts.email;
in
{
  options.${namespace}.editors.emacs.packages.notmuch = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Notmuch package.";
  };

  config = mkIf (email.enable && cfg.enable) {
    programs.mbsync.enable = true;
    programs.msmtp.enable = true;
    programs.notmuch = {
      enable = true;
      hooks = {
        preNew = "mbsync --all";
      };
    };

    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.notmuch ]);
      extraConfig = ''
        (use-package notmuch)
      '';
    };
  };
}
