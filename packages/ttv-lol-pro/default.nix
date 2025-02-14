{ lib, pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  version = "2.3.10";
in
firefox-addons.buildFirefoxXpiAddon {
  pname = "ttv-lol-pro";
  inherit version;
  addonId = "{76ef94a4-e3d0-4c6f-961a-d38a429a332b}";
  url = "https://addons.mozilla.org/firefox/downloads/file/4357094/ttv_lol_pro-${version}.xpi";
  sha256 = "sha256-szzQzU41IVIO8jOyEXkij9reyhaDWayrTCS7saFm/No=";
  meta = {
    homepage = "";
    description = "";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
