{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {
  pname = "skip-netflix-intro";
  version = "1.3";
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
