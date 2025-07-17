{
  config,
  lib,
  pkgs,
  namespace,
  ...
}:
let
  inherit (lib)
    mkIf
    mkMerge
    optionalAttrs
    types
    ;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;
  inherit (pkgs.nur.repos.rycee) firefox-addons;

  cfg = config.${namespace}.browsers.firefox;
in
{
  options.${namespace}.browsers.firefox = with types; {
    enable = mkBoolOpt false "Enable firefox browser.";

    extraConfig = mkOpt str "" "Extra configuration for the user profile JS file.";
    gpuAcceleration = mkBoolOpt false "Enable GPU acceleration.";
    hardwareDecoding = mkBoolOpt false "Enable hardware video decoding.";

    extensions = mkOpt (listOf package) (
      with firefox-addons;
      [
        private-relay
        auto-tab-discard
        user-agent-string-switcher
        return-youtube-dislikes
        ublock-origin
        wappalyzer
        to-deepl
        private-relay
        sponsorblock
        betterttv
        seventv
        dracula-dark-colorscheme
        refined-github
      ]
      ++ (with pkgs.${namespace}; [
        skip-netflix-intro
        darkcloud
        ttv-lol-pro
        twitchnosub
        alerte-sur-les-sites-genai
      ])
    ) "Extensions to install.";

    policies = mkOpt attrs {
      CaptivePortal = false;
      DisableFirefoxStudies = true;
      DisableFormHistory = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisplayBookmarksToolbar = true;
      DontCheckDefaultBrowser = true;
      FirefoxHome = {
        Pocket = false;
        Snippets = false;
      };
      PasswordManagerEnabled = false;
      UserMessaging = {
        ExtensionRecommendations = false;
        SkipOnboarding = true;
      };
      ExtensionSettings = {
        "ebay@search.mozilla.org".installation_mode = "blocked";
        "amazondotcom@search.mozilla.org".installation_mode = "blocked";
        "bing@search.mozilla.org".installation_mode = "blocked";
        "ddg@search.mozilla.org".installation_mode = "blocked";
        "wikipedia@search.mozilla.org".installation_mode = "blocked";
      };
      Preferences = { };
    } "Policies to apply to firefox.";

    # I dont want to copy paste the whole submodule type
    bookmarks = mkOpt (listOf attrs) [
      {
        name = "Barre personnelle";
        toolbar = true;
        bookmarks = [
          {
            name = "Zines";
            bookmarks = [
              {
                name = "OpenBSD Webzine";
                url = "https://webzine.puffy.cafe/";
              }
              {
                name = "wizard zines";
                url = "https://wizardzines.com/";
              }
            ];
          }
          {
            name = "Intéressants";
            bookmarks = [
              {
                name = "hashbang/shell-server: #! shell server base images, ready to boot and allow user logins.";
                url = "https://github.com/hashbang/shell-server";
              }
              {
                name = "Webring";
                url = "https://webring.xxiivv.com/#icons";
              }
              {
                name = "hundred rabbits";
                url = "https://100r.co/";
              }
              {
                name = "icyphox";
                url = "https://icyphox.sh/";
              }
              {
                name = "Accueil | JdLL";
                url = "https://jdll.org/";
              }
              {
                name = "DevOps Roadmap & Learning Path | Kodekloud";
                url = "https://kodekloud.com/learning-path/devops/";
              }
              {
                name = "Site search » Telechargement gratuit des bd comics et mangas";
                url = "https://planete-bd.org/";
              }
            ];
          }
          {
            name = "ArchWiki";
            url = "https://wiki.archlinux.org/";
          }
          {
            name = "Remove Paywall";
            url = "https://www.removepaywall.com/";
          }
          {
            name = "Nix";
            bookmarks = [
              {
                name = "Issues · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/issues?q=is%3Aissue+is%3Aopen+label%3A%220.kind%3A+packaging+request%22";
              }
              {
                name = "nixpkgs/doc/languages-frameworks/python.section.md at master · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md#sec-using-stdenv";
              }
              {
                name = "Documentation: guide for using `let in` vs `rec` vs `finalAttrs` · Issue #315337 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/issues/315337";
              }
              {
                name = "nixpkgs/pkgs at master · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/tree/master/pkgs#reviewing-contributions";
              }
            ];
          }
          {
            name = "Repology";
            url = "https://repology.org/maintainer/theo1.bori@epitech.eu";
          }
          {
            name = "AI Chat";
            url = "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat&duckai=1";
          }
          {
            name = "Cinéma";
            bookmarks = [
              {
                name = "| Berlinale |";
                url = "https://www.berlinale.de/en/home.html";
              }
              {
                name = "(337) SHOWING UP - Bande-annonce - YouTube";
                url = "https://www.youtube.com/watch?v=uTckrM6O8lQ&ab_channel=DiaphanaDistribution";
              }
              {
                name = "Fermer les yeux de Víctor Erice";
                url = "https://www.google.com/search?client=firefox-b-d&sca_esv=ee9f43d054edb7e5&sxsrf=ADLYWIJjIEqIOXSd0s0dBh1XxAlTSIiKFg:1728745583391&q=Fermer+les+yeux+de+V%C3%ADctor+Erice&source=lnms&fbs=AEQNm0CbCVgAZ5mWEJDg6aoPVcBgTlosgQSuzBMlnAdio07UCId2t1azIRgowYJD0nDbqEIN7XYIyS3uBYzHmWPp2pnW1aUeS8cvBgTxtkh0oXYZb9sk4SqfagNzG1TA2KSV_2jiE2u7h5ECeKS1944y5sV2XkToJp-7trbMLUYyqf9k9WkJ34l8HUxr-bw8aCHxPE1stW0M&sa=X&ved=2ahUKEwjMuZ6Tj4mJAxWCT6QEHUT4GUEQ0pQJegQIEhAB&biw=1920&bih=950&dpr=1";
              }
              {
                name = "SensCritique";
                url = "https://www.senscritique.com";
              }
              {
                name = "Letterboxd";
                url = "https://letterboxd.com/";
              }
              {
                name = "Cahiers du cinéma";
                url = "https://www.cahiersducinema.com/fr-fr";
              }
              {
                name = "Will never pay for yggtorrent";
                url = "https://www.yggtorrent.top";
              }

            ];
          }
          {
            name = "Quake";
            bookmarks = [
              {
                name = "Quaddicted";
                url = "https://www.quaddicted.com";
              }
              {
                name = "vkQuake";
                url = "https://github.com/Novum/vkQuake";
              }
            ];
          }
          {
            name = "Excalidraw";
            url = "https://excalidraw.com";
          }

        ];
      }
    ] "Preloaded bookmarks.";

    settings = mkOpt attrs { } "Settings to apply to the profile.";
  };

  config = mkIf cfg.enable {
    stylix.targets.firefox.profileNames = [ config.${namespace}.user.name ];

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };

    programs.firefox = {
      enable = true;

      profiles = {
        ${config.${namespace}.user.name} = {
          id = 0;

          bookmarks = {
            force = true;
            settings = cfg.bookmarks;
          };
          extensions.packages = cfg.extensions;

          inherit (cfg) extraConfig;
          inherit (config.${namespace}.user) name;

          settings = mkMerge [
            cfg.settings
            {
              "accessibility.typeaheadfind.enablesound" = false;
              "accessibility.typeaheadfind.flashBar" = 0;
              "browser.aboutConfig.showWarning" = false;
              "browser.aboutwelcome.enabled" = false;
              "browser.bookmarks.autoExportHTML" = true;
              "browser.bookmarks.showMobileBookmarks" = true;
              "browser.meta_refresh_when_inactive.disabled" = true;
              "browser.newtabpage.activity-stream.default.sites" = "";
              "browser.newtabpage.activity-stream.showSponsored" = false;
              "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
              "browser.search.hiddenOneOffs" = "Google,Amazon.com,Bing,DuckDuckGo,eBay,Wikipedia (en)";
              "browser.search.suggest.enabled" = false;
              "browser.sessionstore.warnOnQuit" = true;
              "browser.shell.checkDefaultBrowser" = false;
              "browser.ssb.enabled" = true;
              "browser.startup.homepage.abouthome_cache.enabled" = true;
              "browser.startup.page" = 3;
              "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
              "browser.urlbar.suggest.quicksuggest.sponsored" = false;
              "devtools.chrome.enabled" = true;
              "devtools.debugger.remote-enabled" = true;
              "dom.storage.next_gen" = true;
              "dom.forms.autocomplete.formautofill" = true;
              "extensions.htmlaboutaddons.recommendations.enabled" = false;
              "extensions.formautofill.addresses.enabled" = false;
              "extensions.formautofill.creditCards.enabled" = false;
              "extensions.autoDisableScopes" = 0; # Automatically enable extensions
              "general.autoScroll" = false;
              "general.smoothScroll.msdPhysics.enabled" = true;
              "geo.enabled" = false;
              "geo.provider.use_corelocation" = false;
              "geo.provider.use_geoclue" = false;
              "geo.provider.use_gpsd" = false;
              "intl.accept_languages" = "en-US,en";
              "media.eme.enabled" = true;
              "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
              "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
              "signon.autofillForms" = false;
              "signon.firefoxRelay.feature" = "disabled";
              "signon.generation.enabled" = false;
              "signon.management.page.breach-alerts.enabled" = false;
              "xpinstall.signatures.required" = false;
            }
            (optionalAttrs cfg.gpuAcceleration {
              "dom.webgpu.enabled" = true;
              "gfx.webrender.all" = true;
              "layers.gpu-process.enabled" = true;
              "layers.mlgpu.enabled" = true;
            })
            (optionalAttrs cfg.hardwareDecoding {
              "media.ffmpeg.vaapi.enabled" = true;
              "media.gpu-process-decoder" = true;
              "media.hardware-video-decoding.enabled" = true;
            })
          ];
        };
      };
    };
  };
}
