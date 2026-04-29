{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {
  pname = "imginn";
  version = "4.0";
  addonId = "{4c62644f-fc4b-4d44-8b51-12f3fb7423b2}";
  url = "https://addons.mozilla.org/firefox/downloads/file/4620508/imginn-${version}.xpi";
  sha256 = "sha256-opLTlCcgmju631g3KMsCoGK8drqGXjk7P9xZ61YMdq4=";
  meta = {
    homepage = "";
    description = "View Instagram without an account";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
