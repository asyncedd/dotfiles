{
  inputs,
  userConfig,
  ...
}: {
  home.username = "async";
  home.homeDirectory = "/home/async";

  imports = [
    inputs.hyprland.homeManagerModules.default
    ./shell
    ./browsers/firefox
    ./editors/neovim
    ./desktop/ags.nix
    ./desktop/hyprland
    ./terminal/kitty
    # ./terminal/foot
    ./software/packages.nix
    ./software/gtk.nix
    ./desktop/hyprlock.nix
    ./xdg.nix
  ];

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = userConfig.editor;
  };

  programs.home-manager.enable = true;
}
