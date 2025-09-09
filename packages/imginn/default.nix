{ lib, pkgs, ... }:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  version = "3.9";
in
firefox-addons.buildFirefoxXpiAddon {
  pname = "imginn";
  inherit version;
  addonId = "{4c62644f-fc4b-4d44-8b51-12f3fb7423b2}";
  url = "https://addons.mozilla.org/firefox/downloads/file/4250290/imginn-${version}.xpi";
  sha256 = "sha256-SMUDzDLZCQk+yM8lJUVJ2LXhtIWD1yNvKu9L6yeb12I=";
  meta = {
    homepage = "";
    description = "View Instagram without an account";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
