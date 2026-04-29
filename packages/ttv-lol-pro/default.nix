{ lib, pkgs, ... }:
pkgs.nur.repos.rycee.firefox-addons.buildFirefoxXpiAddon rec {
  pname = "ttv-lol-pro";
  version = "2.6.1";
  addonId = "{76ef94a4-e3d0-4c6f-961a-d38a429a332b}";
  url = "https://addons.mozilla.org/firefox/downloads/file/4638568/ttv_lol_pro-${version}.xpi";
  sha256 = "sha256-gutff9ZQZxnoYZe5c95ypfTo76s6t+sS6CMxfkxU+vM=";
  meta = {
    homepage = "";
    description = "";
    license = lib.licenses.asl20;
    platforms = lib.platforms.all;
  };
}
