{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {
  pname = "nitter";
  version = "3.8";
  addonId = "{7b74340a-30bf-4a45-aefa-8a0de3096062}";
  url = "https://addons.mozilla.org/firefox/downloads/file/4355534/nitter-${version}.xpi";
  sha256 = "sha256-wdyYgV9qgktStkpFob6l/ORlGCnybQp3aBOH9qf5tDk=";
  meta = {
    homepage = "";
    description = "Redirect all Twitter/X links to use the Nitter instance xcancel.com";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
