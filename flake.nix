{
  description = "flake.nix";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.nixos.org"
      # "https://nyx.chaotic.cx"
      "https://hyprland.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      # "nyx.chaotic.cx-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      # "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    ags.url = "github:Aylur/ags";
    aylur.url = "github:Aylur/dotfiles";
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
    arcwtf = {
      url = "github:KiKaraage/ArcWTF";
      flake = false;
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:Aylur/Astal";
    };
    matugen.url = "github:InioX/matugen";
    sops-nix.url = "github:Mic92/sops-nix";
    xdg-desktop-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
    };

    hyprland.url = "github:hyprwm/Hyprland?ref=v0.34.0";
    hyprlock.url = "github:hyprwm/hyprlock";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nix-alien.url = "github:thiagokokada/nix-alien";
    prismlauncher.url = "github:asyncedd/PrismLauncher";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    # chaotic,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        outputs.overlays.additions
        outputs.overlays.modifications
        outputs.overlays.unstable-packages
        (self: super: {
          fcitx-engines = self.fcitx5;
        })
      ];
    };
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
    nixos-hardware = inputs.nixos-hardware;

    editor = "nvim";
  in {
    formatter = nixpkgs.legacyPackages.${system}.alejandra;
    overlays = import ./overlays/default.nix {inherit inputs outputs;};
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.callPackage "${inputs.aylur}/ags/default.nix" {inherit inputs;};
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          inherit system;
          inherit editor;
          inherit unstable;
          asztal = self.packages.x86_64-linux.default;
        };
        modules = [
          ./nixos/configuration.nix
          ./hosts/nixos/default.nix
          ./modules/shared/nixos.nix
          ./modules/shared/audio.nix
          ./modules/shared/desktop.nix
          ./modules/languages
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-laptop-ssd

          # chaotic.nixosModules.default
          inputs.auto-cpufreq.nixosModules.default
          inputs.sops-nix.nixosModules.sops
        ];
      };
    };
    homeConfigurations = {
      async = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs outputs;
          inherit system;
          inherit editor;
          inherit unstable;
          asztal = self.packages.x86_64-linux.default;
        };
        modules = [
          inputs.hyprland.homeManagerModules.default
          inputs.hyprlock.homeManagerModules.default
          ./home/home.nix
          {
            nixpkgs.overlays = [
              inputs.neovim-nightly-overlay.overlay
            ];
          }
        ];
      };
    };
  };
}
