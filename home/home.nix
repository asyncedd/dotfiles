{ config, pkgs, home-manager, inputs, ... }:

{
  home.username = "async";
  home.homeDirectory = "/home/async";
  
  imports = [
    ./shell/zsh/default.nix
    ./shell/zoxide/default.nix
    ./shell/fzf/default.nix
    ./browsers/firefox/default.nix
    ./desktop/ags/default.nix
    ./desktop/hyprland/default.nix
    ./shell/prompts/starship/default.nix
    ./terminal/kitty/default.nix
    ./software/packages.nix
    ./software/gtk.nix
  ];

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "vim";
  };

  programs.home-manager.enable = true;
}
