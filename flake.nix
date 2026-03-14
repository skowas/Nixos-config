{
  description = "Sko NixOS Modular Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-gaming (used by nix-citizen internally)
    nix-gaming.url = "github:fufexan/nix-gaming";

    # nix-citizen — follows your nixpkgs and nix-gaming
    nix-citizen = {
      url = "github:LovingMelody/nix-citizen";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-gaming.follows = "nix-gaming";
    };
  };

  outputs = { self, nixpkgs, spicetify-nix, nix-citizen, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix

        # Spicetify module
        spicetify-nix.nixosModules.default

        # nix-citizen module
        nix-citizen.nixosModules.default
      ];
    };
  };
}
