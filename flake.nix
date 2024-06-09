{
  description = "flake.nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    ags.url = "github:Aylur/ags";
    aylur.url = "github:Aylur/dotfiles";
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
    omz = {
      url = "github:ohmyzsh/ohmyzsh";
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
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";
    xdg-desktop-portal-hyprland = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
    };

    hyprland.url = "github:hyprwm/Hyprland?ref=v0.34.0";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    prismlauncher.url = "github:asyncedd/PrismLauncher?branch=develop";
    stylix.url = "github:danth/stylix";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    # chaotic,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    lib = nixpkgs.lib;
    system = "x86_64-linux";
    nixos-hardware = inputs.nixos-hardware;

    userConfig = {
      editor = "nvim";
      terminal = "kitty";
      browser = "firefox";
      wallpaper = ./wallpapers/forest-anime.jpg;
    };
  in {
    formatter = nixpkgs.legacyPackages.${system}.alejandra;
    packages.x86_64-linux.default = nixpkgs.legacyPackages.x86_64-linux.callPackage "${inputs.aylur}/ags/default.nix" {inherit inputs;};
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs outputs;
          inherit system;
          inherit userConfig;
          asztal = self.packages.x86_64-linux.default;
        };
        modules = [
          ./nixos/configuration.nix
          ./hosts/nixos/default.nix
          ./modules/shared/audio.nix
          ./modules/shared/desktop.nix
          ./modules/languages
          ./modules/stylix
          nixos-hardware.nixosModules.common-cpu-intel-cpu-only
          nixos-hardware.nixosModules.common-gpu-intel
          nixos-hardware.nixosModules.common-pc-laptop
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-laptop-ssd

          inputs.nix-index-database.nixosModules.nix-index
          {
            programs.nix-index.enable = true;
          }
          {
            programs.command-not-found.enable = false;
          }

          inputs.sops-nix.nixosModules.sops
          inputs.stylix.nixosModules.stylix

          home-manager.nixosModules.home-manager
          {
            nixpkgs = {
              config.allowUnfree = true;
              overlays = [
                inputs.neovim-nightly-overlay.overlays.default
                (self: super: {
                  fcitx-engines = self.fcitx5;
                })
              ];
            };
          }
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.async.imports = [
                inputs.hyprland.homeManagerModules.default
                inputs.sops-nix.homeManagerModules.sops
                ./home/home.nix
                ./modules/home-manager/stylix.nix
              ];
              extraSpecialArgs = {
                inherit inputs system;
                inherit outputs;
                inherit userConfig;
                asztal = self.packages.x86_64-linux.default;
              };
            };
          }
        ];
      };
    };
  };
}
