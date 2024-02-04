# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ 
  config,
  pkgs,
  inputs,
  outputs,
  ... 
}:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
    ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      (self: super: {
        fcitx-engines = self.fcitx5;
      })
    ];
    config = {
      allowUnfree = true;
    };
  };


  hardware.uinput.enable = true;
  users.groups.uinput.members = [ "async" ];
  users.groups.input.members = [ "async" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  programs.dconf.enable = true;

  zramSwap.enable = true;

  hardware.cpu.intel.updateMicrocode = true;
  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = ["i915.fastboot=1" "enable_gvt=1" "iommu=force"];
  };
  # enable the i915 kernel module
  boot.initrd.kernelModules = ["i915"];
  # better performance than the actual Intel driver
  services.xserver.videoDrivers = ["modesetting"];
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        intel-compute-runtime
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };

  xdg.portal.enable = true;
  xdg.portal.extraPortals = 
  with pkgs; [
    pkgs.xdg-desktop-portal-gtk 
    xdg-desktop-portal-wlr
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
  i18n.inputMethod = {
   enabled = "fcitx5";
   # fcitx.engines = with pkgs.fcitx-engines; [ mozc ];
   fcitx5.addons = with pkgs; [
     fcitx5-mozc
     fcitx5-gtk
   ];
  };

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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    scx
    ffmpeg
    zip
    unzip
    gcc
    clang
    zig
    nodejs_21
    sqlite
    sqlitecpp
    luajitPackages.sqlite
    kdenlive
    rustc
    cargo
    rustfmt
    rustPackages.clippy
    tor-browser
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  services.printing.enable = true;

  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
    # vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  security.pam.services.swaylock = {};
  security.pam.services.gtklock = {};

}
