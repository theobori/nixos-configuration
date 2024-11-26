{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types strings;
  inherit (lib.${namespace})
    mkBoolOpt
    mkOpt
    enabled
    disabled
    ;

  cfg = config.${namespace}.messages.discord;

  trimWith' =
    s:
    strings.trimWith {
      start = true;
      end = true;
    } s;
in
{
  options.${namespace}.messages.discord = with types; {
    enable = mkBoolOpt false "Whether or not to manage discord.";
    quickCss = mkOpt str (builtins.readFile ./custom.css) "Vencord quick CSS.";
    config = mkOpt attrs {
      useQuickCss = ((trimWith' cfg.quickCss) != "");
      plugins = {
        # Broken for the moment
        betterFolders = disabled;
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
      vesktop = enabled;

      inherit (cfg) config quickCss;
    };
  };
}
