{ lib, pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  version = "0.9.1";
in
firefox-addons.buildFirefoxXpiAddon {
  pname = "twitchnosub";
  inherit version;
  addonId = "twitchnosub@besuper.com";
  url = "https://github.com/besuper/TwitchNoSub/releases/download/${version}/TwitchNoSub-firefox.${version}.xpi";
  sha256 = "sha256-VuDDVtJELvbwelaXF6nV7MuOapGv3HwJDPcP8JRpnkw=";
  meta = {
    homepage = "https://github.com/besuper/TwitchNoSub";
    description = "An extension to watch sub only VOD on Twitch ";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
