{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    fuzzel
    polkit_gnome
    wlr-randr
    wtype
    wl-clipboard
    hyprland-protocols
    hyprpicker
    swayidle
    gtklock
    swaybg
    xdg-desktop-portal-hyprland
    wlsunset
    pavucontrol
    pamixer
    grim
    slurp
    swappy
  ];
}
