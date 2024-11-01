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

  cfg = config.${namespace}.browsers.firefox;

  inherit (pkgs.nur.repos.rycee) firefox-addons;

  twitchnosub =
    let
      version = "0.7.1";
    in
    firefox-addons.buildFirefoxXpiAddon {
      pname = "twitchnosub";
      inherit version;
      addonId = "twitchnosub@besuper.com";
      url = "https://github.com/besuper/TwitchNoSub/releases/download/${version}/TwitchNoSub-firefox.${version}.xpi";
      sha256 = "sha256-Z/KaWdJy6L/sZXUJlT3nyNnBOf21TxMrQHKxa3j2KD8=";
      meta = {
        homepage = "https://github.com/besuper/TwitchNoSub";
        description = "An extension to watch sub only VOD on Twitch";
        license = lib.licenses.asl20;
        platforms = lib.platforms.all;
      };
    };
in
{
  options.${namespace}.browsers.firefox = with types; {
    enable = mkBoolOpt false "Enable firefox browser.";

    extraConfig = mkOpt str "" "Extra configuration for the user profile JS file.";
    gpuAcceleration = mkBoolOpt false "Enable GPU acceleration.";
    hardwareDecoding = mkBoolOpt false "Enable hardware video decoding.";

    extensions = mkOpt (listOf package) (with firefox-addons; [
      private-relay
      auto-tab-discard
      user-agent-string-switcher
      return-youtube-dislikes
      tab-stash
      stylus
      ublock-origin
      wappalyzer
      dearrow
      to-deepl
      private-relay
      sponsorblock
      dearrow
      betterttv
      seventv

      # My custom addons
      twitchnosub
    ]) "Extensions to install.";

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
            name = "✨ Aesthetics";
            bookmarks = [
              {
                name = "Vampire | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Vampire";
              }
              {
                name = "Y2K | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Y2K#Music";
              }
              {
                name = "Traumacore | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Traumacore#Playlists";
              }
              {
                name = "Pale Grunge | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Pale_Grunge";
              }
              {
                name = "Plant Mom | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Plant_Mom";
              }
              {
                name = "Rococo | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Rococo";
              }
              {
                name = "Bloomcore | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Bloomcore";
              }
              {
                name = "Cyber Fairy Grunge | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Cyber_Fairy_Grunge";
              }
              {
                name = "Devilcore | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Devilcore";
              }
              {
                name = "Darkest Academia | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Darkest_Academia";
              }
              {
                name = "Fairycore | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Fairycore";
              }
              {
                name = "Light Academia | Aesthetics Wiki | Fandom";
                url = "https://aesthetics.fandom.com/wiki/Light_Academia";
              }
            ];
          }
          {
            name = "alt";
            bookmarks = [
              {
                name = "Je veux rejoindre le collectif | La litière";
                url = "https://wiki.chatons.org/doku.php/rejoindre";
              }
              {
                name = "Comment candidater [Guide] | Je veux rejoindre le collectif | La litière";
                url = "https://wiki.chatons.org/doku.php/rejoindre/candidature";
              }
              {
                name = "Obligations | Je veux rejoindre le collectif | La litière";
                url = "https://wiki.chatons.org/doku.php/rejoindre/obligations";
              }
              {
                name = "Nubo";
                url = "https://nubo.coop/fr/";
              }
              {
                name = "docs/Liste_de_conformité_à_la_Charte_CHATONS_V2.pdf · master · CHATONS / Collectif CHATONS · GitLab";
                url = "https://framagit.org/chatons/CHATONS/-/blob/master/docs/Liste_de_conformit%C3%A9_%C3%A0_la_Charte_CHATONS_V2.pdf";
              }
              {
                name = "[candidature] Siick's services (#131) · Tickets · CHATONS / Collectif CHATONS · GitLab";
                url = "https://framagit.org/chatons/CHATONS/-/issues/131";
              }
            ];
          }
          {
            name = "zines";
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
            name = "intéressants";
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
            name = "nix";
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
                name = "python3Packages.phylophlan: init at 3.1.1 by theobori · Pull Request #343699 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/pull/343699";
              }
              {
                name = "python3Packages.salib: init at 1.5.1 by theobori · Pull Request #343803 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/pull/343803/files";
              }
              {
                name = "python3Packages.loompy: init at 3.0.7 by theobori · Pull Request #344042 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/pull/344042";
              }
              {
                name = "reader: init at 0.4.5 by theobori · Pull Request #344489 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/pull/344489";
              }
              {
                name = "Build failure:`or-tools` on `x86_64-darwin`: no member named 'aligned_alloc' in the global namespace · Issue #272156 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/issues/272156";
              }
              {
                name = "ctune: init at 1.3.2 by theobori · Pull Request #346944 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/pull/346944";
              }
              {
                name = "taterclient-ddnet: init at 8.5.4 by theobori · Pull Request #346206 · NixOS/nixpkgs";
                url = "https://github.com/NixOS/nixpkgs/pull/346206";
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
            name = "cinéma";
            bookmarks = [
              {
                name = "| Berlinale |";
                url = "https://www.berlinale.de/en/home.html";
              }
              {
                name = "ANORA - Festival de Cannes";
                url = "https://www.festival-cannes.com/f/anora/";
              }
              {
                name = "(337) SHOWING UP - Bande-annonce - YouTube";
                url = "https://www.youtube.com/watch?v=uTckrM6O8lQ&ab_channel=DiaphanaDistribution";
              }
              {
                name = "Fermer les yeux de Víctor Erice - Recherche Google";
                url = "https://www.google.com/search?client=firefox-b-d&sca_esv=ee9f43d054edb7e5&sxsrf=ADLYWIJjIEqIOXSd0s0dBh1XxAlTSIiKFg:1728745583391&q=Fermer+les+yeux+de+V%C3%ADctor+Erice&source=lnms&fbs=AEQNm0CbCVgAZ5mWEJDg6aoPVcBgTlosgQSuzBMlnAdio07UCId2t1azIRgowYJD0nDbqEIN7XYIyS3uBYzHmWPp2pnW1aUeS8cvBgTxtkh0oXYZb9sk4SqfagNzG1TA2KSV_2jiE2u7h5ECeKS1944y5sV2XkToJp-7trbMLUYyqf9k9WkJ34l8HUxr-bw8aCHxPE1stW0M&sa=X&ved=2ahUKEwjMuZ6Tj4mJAxWCT6QEHUT4GUEQ0pQJegQIEhAB&biw=1920&bih=950&dpr=1";
              }
              {
                name = "Art et culture - Télécharger Des Magazines, Journaux et Livres Gratuitement";
                url = "https://telecharger-magazines.org/art-et-culture";
              }
              {
                name = "Emilia Pérez - Film (2024) - SensCritique";
                url = "https://www.senscritique.com/film/emilia_perez/54313969";
              }
              {
                name = "The Dark Knight - Le Chevalier noir - Film (2008) - SensCritique";
                url = "https://www.senscritique.com/film/the_dark_knight_le_chevalier_noir/419456";
              }
            ];
          }
          {
            name = "Lib | Snowfall";
            url = "https://snowfall.org/reference/lib/#libmkflake";
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
        "dev-edition-default" = {
          id = 0;
          path = "${config.${namespace}.user.name}";
        };

        ${config.${namespace}.user.name} = {
          inherit (cfg) extraConfig extensions bookmarks;
          inherit (config.${namespace}.user) name;

          id = 1;

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
