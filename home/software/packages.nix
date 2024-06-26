{ pkgs, inputs, system, ... }: {
  home.packages = with pkgs; [
    ripgrep
    lazygit
    feh
    keepassxc
    mpv
    eza
    yazi

    (obsidian.overrideAttrs (e: rec {
      # Add arguments to the .desktop entry
      desktopItem = e.desktopItem.override
        (d: { exec = "${d.exec} --enable-wayland-ime "; });

      # Update the install script to use the new .desktop entry
      installPhase =
        builtins.replaceStrings [ "${e.desktopItem}" ] [ "${desktopItem}" ]
        e.installPhase;
    }))
    (brave.override { commandLineArgs = "--enable-wayland-ime"; })

    vesktop
    krabby
    (inputs.prismlauncher.packages.${system}.prismlauncher.override {
      jdks = [ jdk17 jdk8 jdk21 ];
    })
    pavucontrol
    wlr-randr
    wtype
    wl-clipboard
    hyprland-protocols
    hyprpicker
  ];
}
