{
  description = "NixOS flakes config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { system = system; config.allowUnfree = true; };
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        modules = [
          ./configuration.nix
          ./users/shine/home.nix
          ./modules/docker.nix
          ./modules/nvidia.nix
          ./modules/k3s.nix
          home-manager.nixosModules.default
        ];
      };
    };
}
