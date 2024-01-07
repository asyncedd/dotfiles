{
  imports =
    [
      ./packages.nix
      ./config.nix
    ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
