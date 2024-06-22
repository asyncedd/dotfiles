{
  description = "flake.nix";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    ags.url = "github:Aylur/ags";
    ags.inputs.nixpkgs.follows = "nixpkgs";
    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
    };
    omz = {
      url = "github:ohmyzsh/ohmyzsh";
      flake = false;
    };
    astal = {
      url = "github:Aylur/Astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    matugen.inputs.nixpkgs.follows = "nixpkgs";
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
    prismlauncher.url = "github:asyncedd/PrismLauncher?branch=develop";
    prismlauncher.inputs.nixpkgs.follows = "nixpkgs";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    firefox-csshacks = {
      url = "github:MrOtherGuy/firefox-csshacks";
      flake = false;
    };
    arcwtf = {
      url = "github:KiKaraage/ArcWTF";
      flake = false;
    };
    edgyarc-fr = {
      url = "github:artsyfriedchicken/EdgyArc-fr";
      flake = false;
    };
    shyfox = {
      url = "github:asyncedd/ShyFox";
      flake = false;
    };
    edge-frfox = {
      url = "github:bmFtZQ/edge-frfox";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      # chaotic,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      system = "x86_64-linux";
    in
    {
      formatter = nixpkgs.legacyPackages.${system}.alejandra;
      packages.x86_64-linux.default =
        nixpkgs.legacyPackages.x86_64-linux.callPackage "${./ags}/default.nix"
          { inherit inputs; };
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs outputs;
            inherit system;
            asztal = self.packages.x86_64-linux.default;
          };
          modules = [
            ./nixos/configuration.nix
            ./modules/languages/lsp.nix
            ./modules/stylix
            inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
            inputs.nixos-hardware.nixosModules.common-gpu-intel
            inputs.nixos-hardware.nixosModules.common-pc-laptop
            inputs.nixos-hardware.nixosModules.common-pc
            inputs.nixos-hardware.nixosModules.common-pc-laptop-ssd

            inputs.sops-nix.nixosModules.sops
            inputs.stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            { home-manager.backupFileExtension = "bak"; }
            {
              nixpkgs = {
                config.allowUnfree = true;
                overlays = [
                  inputs.neovim-nightly-overlay.overlays.default
                  (self: super: { fcitx-engines = self.fcitx5; })
                ];
              };
            }
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.async.imports = [
                  inputs.sops-nix.homeManagerModules.sops
                  ./home/home.nix
                  ./modules/home-manager/stylix.nix
                ];
                extraSpecialArgs = {
                  inherit inputs system;
                  inherit outputs;
                  asztal = self.packages.x86_64-linux.default;
                };
              };
            }
          ];
        };
      };
    };
}
