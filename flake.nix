{
  description = "theobori's Nix/NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11-small";

    # We assume this version of nixpkgs is more updated than the `nixpkgs` input.
    # Will be used within overlay to get the latest version of specific packages.
    unstable.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware = {
      url = "github:nixos/nixos-hardware";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    nixgl.url = "github:nix-community/nixGL";
    nix-index-database.url = "github:nix-community/nix-index-database";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-anywhere = {
      url = "github:numtide/nixos-anywhere";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.disko.follows = "disko";
    };

    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks-nix.url = "github:cachix/pre-commit-hooks.nix";

    mkdocs-flake.url = "github:applicative-systems/mkdocs-flake";

    nixcord.url = "github:kaylorben/nixcord";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs =
    inputs:
    let
      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          metadata = "theobori-nix";
          namespace = "theobori-nix";
          meta = {
            name = "theobori-nix";
            title = "theobori's Nix Flake";
          };
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      overlays = with inputs; [
        nur.overlay
        nixgl.overlay
      ];

      homes.modules = with inputs; [
        nix-index-database.hmModules.nix-index
        stylix.homeManagerModules.stylix
        sops-nix.homeManagerModules.sops
        nixcord.homeManagerModules.nixcord
        plasma-manager.homeManagerModules.plasma-manager
      ];

      systems = {
        modules = {
          nixos = with inputs; [
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            disko.nixosModules.disko
          ];
        };
      };

      outputs-builder = channels: { formatter = channels.nixpkgs.nixfmt-rfc-style; };

      templates = {
        xdp-c.description = "My template for building a XDP program in C";
        python.description = "My template for a base project in Python";
      };
    };
}
