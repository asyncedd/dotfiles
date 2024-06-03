{inputs, ...}: {
  imports = [
    ./packages.nix
    ./config.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.x86_64-linux.hyprland;
  };
}
