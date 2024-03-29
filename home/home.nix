{
  config,
  pkgs,
  home-manager,
  inputs,
  editor,
  ...
}: {
  home.username = "async";
  home.homeDirectory = "/home/async";

  imports = [
    ./shell/zsh/default.nix
    ./shell/zoxide/default.nix
    ./shell/fzf/default.nix
    ./browsers/firefox/default.nix
    ./editors/neovim/default.nix
    ./desktop/ags/default.nix
    ./desktop/hyprland/default.nix
    ./shell/prompts/starship/default.nix
    ./terminal/kitty/default.nix
    ./software/packages.nix
    ./software/gtk.nix
  ];

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = editor;
  };

  programs.home-manager.enable = true;
}
