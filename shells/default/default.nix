{
  pkgs,
  inputs,
  mkShell,
  system,
  ...
}:
mkShell {
  packages = with pkgs; [
    nh
    inputs.nixos-anywhere.packages.${system}.nixos-anywhere
    python312Packages.mkdocs-material

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

    # Adds all the packages required for the pre-commit checks
    inputs.self.checks.${system}.pre-commit-hooks.enabledPackages
  ];

  shellHook = ''
    ${inputs.self.checks.${system}.pre-commit-hooks.shellHook}
  '';
}
