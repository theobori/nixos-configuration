# Using the AppImage instead of the openshot-qt package because
# qtwebengine is not avaible in the official Nix binary caches
#
# In my case its faster to fetch the AppImage than
# building openshot-qt from scratch

{ appimageTools, fetchurl }:
let
  pname = "openshot";
  version = "3.5.1";

  src = fetchurl {
    url = "https://github.com/OpenShot/openshot-qt/releases/download/v${version}/OpenShot-v${version}-x86_64.AppImage";
    hash = "sha256-L/eiWW5SRsOVsIxA/YbSeMDLReS/fumSdCO6MvH02I0=";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs = pkgs: [ pkgs.libva ];

  extraInstallCommands = ''
    install -m 444 -D ${appimageContents}/org.openshot.OpenShot.desktop $out/share/applications/org.openshot.OpenShot.desktop
    install -m 444 -D ${appimageContents}/openshot-qt.svg $out/share/icons/hicolor/scalable/apps/openshot-qt.svg
    substituteInPlace $out/share/applications/org.openshot.OpenShot.desktop \
      --replace-fail 'Exec=openshot-qt-launch' 'Exec=openshot'
  '';
}
