{
  config,
  lib,
  pkgs,
  namespace,
  inputs,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.programs.spicetify;
in
{
  options.${namespace}.programs.spicetify = {
    enable = mkBoolOpt false "Whether or not to manage spicetify.";
  };

  config = mkIf cfg.enable {
    stylix.targets.spicetify.enable = false;

    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      in
      {
        enable = true;

        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
          history
          betterGenres
          autoSkipVideo
          trashbin
          wikify
          songStats
        ];

        enabledCustomApps = with spicePkgs.apps; [ lyricsPlus ];

        theme = spicePkgs.themes.dracula;
        # colorScheme = "dracula";
      };
  };
}
