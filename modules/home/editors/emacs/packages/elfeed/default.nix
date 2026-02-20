{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.elfeed;
in
{
  options.${namespace}.editors.emacs.packages.elfeed = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Elfeed package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.elfeed ]);
      extraConfig = ''
        (use-package elfeed
          :custom
          (elfeed-feeds '("https://www.journalduhacker.net/rss"
                          "https://tilde.news/rss"
                          "https://lobste.rs/rss"
                          "https://news.ycombinator.com/rss")))
      '';
    };
  };
}
