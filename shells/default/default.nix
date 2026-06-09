{
  pkgs,
  inputs,
  mkShell,
  system,
  ...
}:
mkShell {
  packages = builtins.attrValues {
    inherit (pkgs)
      nh
      statix
      deadnix
      home-manager
      git
      sops
      ssh-to-age
      gnupg
      age
      act
      hydra-check
      nix-inspect
      nix-bisect
      nix-diff
      nix-health
      nix-index
      nix-melt
      nix-prefetch-git
      nix-search-cli
      nix-tree
      nixpkgs-hammering
      nixpkgs-lint
      ;

    inherit (pkgs.python312Packages) mkdocs-material;
    inherit (inputs.nixos-anywhere.packages.${system}) nixos-anywhere;
    inherit (inputs.self.checks.${system}.pre-commit-hooks) enabledPackages;
  };

  shellHook = ''
    ${inputs.self.checks.${system}.pre-commit-hooks.shellHook}
  '';
}
