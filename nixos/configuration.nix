# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./fonts.nix
    ../modules/nixos/fcitx5.nix
    ../modules/nixos/security.nix
    ../modules/nixos/secrets.nix
    ../modules/nixos/nix-daemon.nix
    ../modules/hardware.nix
    ../modules/battery.nix
  ];

  hardware.uinput.enable = true;
  users.groups.uinput.members = ["async"];
  users.groups.input.members = ["async"];

  # Bootloader.
  boot.loader.systemd-boot.enable = lib.mkForce true;
  boot.loader.efi.canTouchEfiVariables = true;

  programs.dconf.enable = true;

  zramSwap.enable = true;

  # better performance than the actual Intel driver
  services.xserver.videoDrivers = ["modesetting"];

  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
    inputs.xdg-desktop-portal-hyprland
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.async = {
    isNormalUser = true;
    description = "async";
    extraGroups = ["networkmanager" "wheel"];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    # scx
    ffmpeg
    zip
    unzip
    zig
    nodejs_22
    sqlite
    tor-browser
    vscodium
    hyperfine

    bash

    p7zip

    # lsp: https://www.reddit.com/r/neovim/comments/1b4bk5h/psa_new_fswatch_watchfunc_backend_available_on/
    fswatch
    fd

    nix-output-monitor
    nvd
    nh

    xdg-utils
    age
    pkg-config
    openssl
    inputs.matugen.packages.${system}.default
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.printing.enable = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    zlib
    qt5.full
    qtcreator
    stdenv.cc.cc.lib
  ];

  environment.variables = lib.mkForce {
    sqlite_nix_path = "${pkgs.sqlite.out}";
    XDG_DATA_DIRS = with pkgs; "$XDG_DATA_DIRS:${gtk3}/share/gsettings-schemas/gtk+3-${gtk3.version}:${gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-${gsettings-desktop-schemas.version}";
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = ["graphical-session.target"];
      wants = ["graphical-session.target"];
      after = ["graphical-session.target"];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };

  services = {
    gvfs.enable = true;
    devmon.enable = true;
    udisks2.enable = true;
    upower.enable = true;
    # power-profiles-daemon.enable = true;
    accounts-daemon.enable = true;
    gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
    };
  };

  # services.greetd = {
  #   enable = true;
  #   settings.default_session.command = pkgs.writeShellScript "greeter" ''
  #     export XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}
  #     export XCURSOR_THEME=Qogir
  #     ${asztal}/bin/greeter
  #   '';
  # };
  #
  # systemd.tmpfiles.rules = [
  #   "d '/var/cache/greeter' - greeter greeter - -"
  # ];

  # services.xserver.displayManager.startx.enable = true;

  hardware.opengl.enable = true;

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/user/.dotfiles";
  };
}
