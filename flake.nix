{
  description = "flake.nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    ags.url = "github:Aylur/ags";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    arkenfox = {
      url = "github:arkenfox/user.js";
      flake = false;
    };
    firefox-csshacks = {
      url = "github:MrOtherGuy/firefox-csshacks";
      flake = false;
    };
    lepton = { 
      url = "github:black7375/Firefox-UI-Fix";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, unstable, chaotic, home-manager, ... }@inputs: let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = unstable.legacyPackages.${system};
      nixos-hardware = inputs.nixos-hardware;
    in {
    formatter = nixpkgs.legacyPackages.${system}.alejandra;
    overlays = import ./overlays/default.nix { inherit inputs outputs; };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-laptop-ssd
          chaotic.nixosModules.default
        ];
      };
    };
    homeConfigurations = {
      async = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs outputs; };
        modules = [
          ./home/home.nix
        ];
      };
    };
  };
}
