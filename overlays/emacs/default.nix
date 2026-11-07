{ channels, ... }:

_final: _prev: {
  # Emacs was broken on "stable" nixpkgs, see below.
  #
  # tramp-dissect-file-name: Symbol’s function definition is void: tramp-get-connection-local-criteria
  inherit (channels.unstable) emacs;
}
