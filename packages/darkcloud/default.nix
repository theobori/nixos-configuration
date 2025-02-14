{ lib, pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  version = "1.6.6";
in
firefox-addons.buildFirefoxXpiAddon {
  pname = "darkcloud";
  inherit version;
  addonId = "{534c6d6e-de02-417d-a38e-4007d33914b6}";
  url = "https://addons.mozilla.org/firefox/downloads/file/4333468/darkcloud-${version}.xpi";
  sha256 = "sha256-8ZYOh8c7c/7UCpQ/mgeOkHfZCBj9aD973auCbTcVMzQ=";
  meta = {
    homepage = "http://acroma.rf.gd/darkcloud";
    description = "Changes soundcloud.com to a dark theme";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
