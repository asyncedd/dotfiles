{ pkgs, ... }:

{
  home.packages = with pkgs; [
    udev-gothic-nf
    ripgrep
    lazygit
  ];
}
