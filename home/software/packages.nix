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
    mpv
    btop
    eza
    yazi

    unstable.obsidian
  ];
}
