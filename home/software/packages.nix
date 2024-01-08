{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ripgrep
    lazygit
    feh
    keepassxc
  ];
}
