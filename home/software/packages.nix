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
    neovide

    (unstable.obsidian.overrideAttrs (e: rec {
      # Add arguments to the .desktop entry
      desktopItem = e.desktopItem.override (d: {
        exec = "${d.exec} --enable-wayland-ime ";
      });

      # Update the install script to use the new .desktop entry
      installPhase = builtins.replaceStrings ["${e.desktopItem}"] ["${desktopItem}"] e.installPhase;
    }))
  ];
}
