{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace})
    mkBoolOpt
    mkOpt
    enabled
    disabled
    ;

  cfg = config.${namespace}.messages.discord;
in
{
  options.${namespace}.messages.discord = with types; {
    enable = mkBoolOpt false "Whether or not to manage discord.";
    config = mkOpt attrs {
      useQuickCss = true;
      plugins = {
        betterFolders = enabled;
        betterRoleContext = enabled;
        crashHandler = enabled;
        memberCount = enabled;
        mentionAvatars = enabled;
        messageLatency = enabled;
        showHiddenThings = enabled;
        showMeYourName = enabled;
        webContextMenus = enabled;
        webKeybinds = enabled;
        webScreenShareFixes = enabled;
        alwaysAnimate = enabled;
      };
    } "Manage the nixcord configuration.";
  };

  config = mkIf cfg.enable {
    stylix.targets.vesktop.enable = false;

    programs.nixcord = {
      enable = true;
      discord = disabled;
      vesktop.enable = true;
      quickCss = builtins.readFile ./custom.css;

      inherit (cfg) config;
    };
  };
}
