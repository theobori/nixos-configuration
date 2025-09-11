{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {
  pname = "twitchnosub";
  version = "0.9.2";
  addonId = "twitchnosub@besuper.com";
  url = "https://github.com/besuper/TwitchNoSub/releases/download/${version}/TwitchNoSub-firefox.${version}.xpi";
  sha256 = "sha256-EzymNANCbKPto6mLsQgdp8CZevW/xS7S+4Z/IxE5NBk=";
  meta = {
    homepage = "https://github.com/besuper/TwitchNoSub";
    description = "An extension to watch sub only VOD on Twitch";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
