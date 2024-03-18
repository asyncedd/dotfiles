{
  pkgs,
  unstable,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    ripgrep
    lazygit
    feh
    keepassxc
    unstable.obsidian
    # neovim
    mpv
    gnome.gnome-tweaks
    btop
    eza
    yazi
  ];
}
