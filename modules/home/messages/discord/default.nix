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
        betterFolders = disabled; # Broken for the moment

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
        petpet = enabled;
        betterGifAltText = enabled;
        betterSettings = enabled;
        callTimer = disabled; # Causes voice chat crashloop for the moment
        copyUserURLs = enabled;
        disableCallIdle = enabled;
        fixImagesQuality = enabled;
        forceOwnerCrown = enabled;
        friendInvites = enabled;
        friendsSince = enabled;
        fullSearchContext = enabled;
        moreCommands = enabled;
        newGuildSettings = enabled;
        noOnboardingDelay = enabled;
        permissionsViewer = enabled;
        previewMessage = enabled;
        relationshipNotifier = enabled;
        replaceGoogleSearch = enabled; # DuckDuckGo by default !
        serverInfo = enabled;
        shikiCodeblocks = enabled;
        silentTyping = enabled;
        typingTweaks = enabled;
        viewIcons = enabled;
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
