{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon {
  pname = "alerte-sur-les-sites-genai";
  version = "2.3.1";
  addonId = "sebastien@gavois.fr";
  url = "https://addons.mozilla.org/firefox/downloads/file/4574241/alerte_sur_les_sites_genai-2.3.1.xpi";
  sha256 = "sha256-WAJSPXOTLNPlEFM7q07L5sQEgnuf5NFkfBRi6+VtZO0=";
  meta = {
    homepage = "https://next.ink";
    description = "Displays an alert for sites generated in whole or in part by AI";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
