{ lib, pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  version = "1.3";
in
firefox-addons.buildFirefoxXpiAddon {
  pname = "skip-netflix-intro";
  inherit version;
  addonId = "skip_netflix_intro@jonas-hellmann.de";
  url = "https://addons.mozilla.org/firefox/downloads/file/3898270/skip_netflix_intro-${version}.xpi";
  sha256 = "sha256-fcoBZcMMrQi5kYh4k27DrlmnZ9lUMYcVwnkjxUPxYK4=";
  meta = {
    homepage = "https://addons.mozilla.org/fr/firefox/addon/skip-netflix-intro/";
    description = "Addon to automatically skip intros on Netflix";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
