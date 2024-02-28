{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "opacity 0.80 0.80,class:^(kitty)$"
      "opacity 0.80 0.80,class:^(obsidian)$"
    ];
  };
}
