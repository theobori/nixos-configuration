{
  browserName ? "firefox",
}:
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

  cfg = config.${namespace}.browsers.${browserName};
in
{
  options.${namespace}.browsers.${browserName} = with types; {
    enable = mkBoolOpt false "Enable ${browserName} browser.";

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
        nitter
        imginn
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
    } "Policies to apply to ${browserName}.";

    # I dont want to copy paste the whole submodule type,
    # so I use (listOf attrs).
    bookmarks = mkOpt (listOf attrs) [
      {
        name = "Barre personnelle";
        toolbar = true;
        bookmarks = [
          {
            name = "Remove Paywall";
            url = "https://www.removepaywall.com";
          }
          {
            name = "Nix";
            bookmarks = [
              {
                name = "Nixpkgs issues";
                url = "https://github.com/NixOS/nixpkgs/issues?q=is%3Aissue+is%3Aopen+label%3A%220.kind%3A+packaging+request%22";
              }
              {
                name = "Python Nix documentation";
                url = "https://github.com/NixOS/nixpkgs/blob/master/doc/languages-frameworks/python.section.md#sec-using-stdenv";
              }
              {
                name = "Documentation: guide for using `let in` vs `rec` vs `finalAttrs` · Issue #315337 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/issues/315337";
              }
              {
                name = "Nixpkgs";
                url = "https://github.com/NixOS/nixpkgs";
              }
            ];
          }
          {
            name = "Repology";
            url = "https://repology.org/maintainer/theobori@disroot.org";
          }
          {
            name = "AI";
            url = "https://duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat&duckai=1";
          }
          {
            name = "No AI";
            url = "https://noai.duckduckgo.com";
          }
          {
            name = "Cinéma";
            bookmarks = [
              {
                name = "| Berlinale |";
                url = "https://www.berlinale.de/en/home.html";
              }
              {
                name = "SensCritique";
                url = "https://www.senscritique.com";
              }
              {
                name = "Letterboxd";
                url = "https://letterboxd.com";
              }
              {
                name = "Cahiers du cinéma";
                url = "https://www.cahiersducinema.com/fr-fr";
              }
              {
                name = "I Will never pay for yggtorrent";
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
          {
            name = "Disroot";
            url = "https://disroot.org";
          }
          {
            name = "Link aggregators";
            bookmarks = [
              {
                name = "Journal du hacker";
                url = "https://www.journalduhacker.net";
              }
              {
                name = "Tilde news";
                url = "https://tilde.news";
              }
              {
                name = "Lobsters";
                url = "https://lobste.rs/";
              }
              {
                name = "Hacker News";
                url = "https://news.ycombinator.com/";
              }
            ];
          }
          {
            name = "Pubnixes I use";
            bookmarks = [
              {
                name = "~team";
                url = "https://tilde.team";
              }
              {
                name = "~town";
                url = "https://tilde.town";
              }
              {
                name = "~pink";
                url = "https://tilde.pink";
              }
              {
                name = "Comsic Voyage";
                url = "https://cosmic.voyage";
              }
            ];
          }
        ];
      }
    ] "Preloaded bookmarks.";

    settings = mkOpt attrs { } "Settings to apply to the profile.";
  };

  config = mkIf cfg.enable {
    stylix.targets.${browserName}.profileNames = [ config.${namespace}.user.name ];

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "${browserName}.desktop" ];
      "text/xml" = [ "${browserName}.desktop" ];
      "x-scheme-handler/http" = [ "${browserName}.desktop" ];
      "x-scheme-handler/https" = [ "${browserName}.desktop" ];
    };

    programs.${browserName} = {
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
              "browser.ml.enable" = false;
              "browser.ml.chat.enabled" = false;
              "browser.ml.chat.menu" = false;
              "browser.ml.chat.page" = false;
              "browser.ml.chat.page.footerBadge" = false;
              "browser.ml.chat.page.menuBadge" = false;
              "cookiebanners.service.mode.privateBrowsing" = 2;
              "cookiebanners.service.mode" = 2;
              "privacy.donottrackheader.enabled" = true;
              "privacy.fingerprintingProtection" = true;
              "privacy.resistFingerprinting" = true;
              "privacy.trackingprotection.emailtracking.enabled" = true;
              "privacy.trackingprotection.enabled" = true;
              "privacy.trackingprotection.fingerprinting.enabled" = true;
              "privacy.trackingprotection.socialtracking.enabled" = true;
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
