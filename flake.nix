{
  description = "theobori's Nix/NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    # We assume this version of nixpkgs is more updated than the `nixpkgs` input.
    # Will be used within overlay to get the latest version of specific packages.
    unstable.url = "github:nixos/nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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

    stylix.url = "github:danth/stylix/release-25.05";
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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    nsearch = {
      url = "github:niksingh710/nsearch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak/latest";

    hosts.url = "github:StevenBlack/hosts";

    xremap-flake.url = "github:xremap/nix-flake";

    treefmt-nix.url = "github:numtide/treefmt-nix";
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
        # keep-sorted start
        nixgl.overlay
        nur.overlays.default
        # keep-sorted end
      ];

      homes.modules = with inputs; [
        # keep-sorted start
        nix-index-database.homeModules.nix-index
        nixcord.homeModules.nixcord
        plasma-manager.homeModules.plasma-manager
        sops-nix.homeManagerModules.sops
        spicetify-nix.homeManagerModules.default
        stylix.homeModules.stylix
        # flatpaks.homeModule
        # keep-sorted end
      ];

      systems = {
        modules = {
          nixos = with inputs; [
            # keep-sorted start
            disko.nixosModules.disko
            home-manager.nixosModules.home-manager
            hosts.nixosModule
            stylix.nixosModules.stylix
            xremap-flake.nixosModules.default
            # keep-sorted end
          ];
        };
      };

      outputs-builder = channels: {
        formatter =
          let
            treefmtEval = inputs.treefmt-nix.lib.evalModule channels.nixpkgs ./treefmt.nix;
          in
          treefmtEval.config.build.wrapper;
      };

      templates = {
        xdp-c.description = "My template for building a XDP program in C";
        python.description = "My template for a base project in Python";
        latex.description = "My template for a base project in Latex";
        go.description = "My template for a base project in Go";
      };
    };
}
