{
  description = "flake.nix";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      "https://nyx.chaotic.cx"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

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
    edge-frfox = { 
      url = "github:bmFtZQ/edge-frfox";
      flake = false;
    };
    firefox-mod-blur = {
      url = "github:datguypiko/Firefox-Mod-Blur";
      flake = false;
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland?ref=v0.34.0";
  };

  outputs = { self, nixpkgs, unstable, chaotic, home-manager, ... }@inputs: let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = unstable.legacyPackages.${system};
      nixos-hardware = inputs.nixos-hardware;

      editor = "nvim";
    in {
    formatter = nixpkgs.legacyPackages.${system}.alejandra;
    overlays = import ./overlays/default.nix { inherit inputs outputs; };
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs outputs; };
        modules = [
          ./nixos/configuration.nix
          ./hosts/nixos/default.nix
          ./modules/shared/nixos.nix
          ./modules/shared/audio.nix
          ./modules/shared/desktop.nix
          ./modules/shared/security
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
