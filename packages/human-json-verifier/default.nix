{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon {
  pname = "human-json-verifier";
  version = "0.1.5";
  addonId = "human-json-verifier@robida.net";
  url = "https://addons.mozilla.org/firefox/downloads/file/4740157/human_json_verifier-0.1.5.xpi";
  sha256 = "sha256-i5xlSDMssr0q0ajhlCnAHafNPzgSf9sVn9ghlUjdfDw=";
  meta = {
    homepage = "https://codeberg.org/robida/human.json";
    description = "A lightweight protocol for humans to assert authorship of their website content and vouch for the humanity of others.";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
