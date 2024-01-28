{ pkgs, inputs, ... }:

{
  services.xserver.enable = true;

  services.xserver.displayManager.sddm.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };
}
