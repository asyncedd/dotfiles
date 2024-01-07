{ config, pkgs, home-manager, inputs, ... }:

{
  home.username = "async";
  home.homeDirectory = "/home/async";
  
  imports = [
    ./shell/zsh/default.nix
    ./browsers/firefox/default.nix
    ./desktop/wm/hyprland/default.nix
    ./shell/prompts/starship/default.nix
    ./terminal/kitty/default.nix
    ./software/packages.nix
  ];
 
  fonts.fontconfig.enable = true;

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
