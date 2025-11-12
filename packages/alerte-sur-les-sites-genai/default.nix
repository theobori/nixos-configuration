{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon {
  pname = "alerte-sur-les-sites-genai";
  version = "2.5.5";
  addonId = "sebastien@gavois.fr";
  url = "https://addons.mozilla.org/firefox/downloads/file/4618291/alerte_sur_les_sites_genai-2.5.5.xpi";
  sha256 = "sha256-ZFkfEDIEhseJOpbRXCtZFbqUU8fBizLrtcA/W6k7L90=";
  meta = {
    homepage = "https://next.ink";
    description = "Displays an alert for sites generated in whole or in part by AI";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
