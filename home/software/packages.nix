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

  # nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "obsidian-1.5.8"
  #   ];
}
