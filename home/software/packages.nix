{
  pkgs,
  unstable,
  ...
}: {
  home.packages = with pkgs; [
    ripgrep
    lazygit
    feh
    keepassxc
    # neovim
    mpv
    gnome.gnome-tweaks
    btop
    eza
    yazi
    sass

    unstable.obsidian
  ];
}
