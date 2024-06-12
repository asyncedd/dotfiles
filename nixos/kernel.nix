{
  pkgs,
  lib,
  ...
}: {
  boot = {
    kernelModules = ["kvm-intel"];
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    # Enable "Silent Boot"
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "enable_gvt=1"
      "iommu=force"
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
    ];
    # Bootloader.
    loader.systemd-boot.enable = lib.mkForce true;
    loader.efi.canTouchEfiVariables = true;
  };
}
