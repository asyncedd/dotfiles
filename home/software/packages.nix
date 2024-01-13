{ pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    lazygit
    feh
    keepassxc
    obsidian
    neovim
    mpv
    gnome.gnome-tweaks
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "obsidian"
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-25.9.0"
  ];
}
