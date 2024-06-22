{
  home.username = "async";
  home.homeDirectory = "/home/async";

  imports = [
    ./shell
    ./browsers/firefox
    ./editors/neovim
    ./desktop/ags.nix
    ./desktop/hyprland
    ./terminal/kitty
    ./terminal/foot
    ./software/packages.nix
    ./software/gtk.nix
    ./desktop/hyprlock.nix
    ./config/cava.nix
    ./config/hypridle.nix
  ];

  home.stateVersion = "23.11";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.home-manager.enable = true;

  home.file.".face".source = ../assets/PFP/luckystar01.jpg;
}
