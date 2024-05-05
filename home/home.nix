{editor, ...}: {
  home.username = "async";
  home.homeDirectory = "/home/async";

  imports = [
    # ./shell/zsh
    ./shell/nushell.nix
    ./shell/zoxide
    ./shell/fzf
    ./browsers/firefox
    ./editors/neovim
    ./desktop/ags.nix
    ./desktop/hyprland
    ./shell/prompts/starship
    ./terminal/kitty
    ./software/packages.nix
    ./software/gtk.nix
    ./desktop/hyprlock.nix
  ];

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = editor;
  };

  programs.home-manager.enable = true;
}
