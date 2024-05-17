{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    fuzzel
    polkit_gnome
    wlr-randr
    wtype
    wl-clipboard
    hyprland-protocols
    hyprpicker
    swayidle
    swaybg
    xdg-desktop-portal-hyprland
    wlsunset
    pavucontrol
    pamixer
    grim
    slurp
    swappy
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
  ];
}
