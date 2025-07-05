{ lib, pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  version = "2.2.1";
in
firefox-addons.buildFirefoxXpiAddon {
  pname = "alerte-sur-les-sites-genai";
  inherit version;
  addonId = "sebastien@gavois.fr";
  url = "https://addons.mozilla.org/firefox/downloads/file/4510278/alerte_sur_les_sites_genai-${version}.xpi";
  sha256 = "sha256-rHusk8LEQs5tB+TPgKi/5kjZ3FvtnFQ470JCFypPCUs=";
  meta = {
    homepage = "";
    description = "Displays an alert for sites generated in whole or in part by AI.";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
