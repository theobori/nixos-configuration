{
  description = "theobori's Nix/NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";

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

    treefmt-nix.url = "github:numtide/treefmt-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      systems,
      ...
    }@inputs:
    let
      eachSystem = f: nixpkgs.lib.genAttrs (import systems) (system: f nixpkgs.legacyPackages.${system});

      treefmtEval = eachSystem (pkgs: inputs.treefmt-nix.lib.evalModule pkgs ./treefmt.nix);

      lib = inputs.snowfall-lib.mkLib {
        inherit inputs;
        src = ./.;

        snowfall = {
          metadata = "theobori-org";
          namespace = "theobori-org";
          meta = {
            name = "theobori-org";
            title = "theobori's Nix Flake";
          };
        };
      };
    in
    lib.mkFlake {
      channels-config = {
        allowUnfree = true;
      };

      systems.modules.nixos = with inputs; [
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
      ];

      overlays = with inputs; [
        nur.overlay
        nixgl.overlay
      ];

      formatter = eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);

      checks = eachSystem (pkgs: {
        formatting = treefmtEval.${pkgs.system}.config.build.check inputs.self;
      });
    };
}
