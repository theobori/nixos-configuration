{ lib, pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  version = "2.3";
in
firefox-addons.buildFirefoxXpiAddon {
  pname = "alerte-sur-les-sites-genai";
  inherit version;
  addonId = "sebastien@gavois.fr";
  url = "https://addons.mozilla.org/firefox/downloads/file/4556934/alerte_sur_les_sites_genai-${version}.xpi";
  sha256 = "sha256-5TDgQScsX9E6Jy9NlhC0l8OVHKCdyUxvwZ4n2z6VmOk=";
  meta = {
    homepage = "https://next.ink";
    description = "Displays an alert for sites generated in whole or in part by AI.";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
