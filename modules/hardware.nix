{
  config,
  lib,
  pkgs,
  ...
}: {
  boot.initrd.kernelModules = ["i915"];
  environment.variables = {
    VDPAU_DRIVER = lib.mkIf config.hardware.opengl.enable (lib.mkDefault "va_gl");
  };
  hardware.opengl.extraPackages = with pkgs; [
    intel-vaapi-driver
    libvdpau-va-gl
    intel-media-driver
  ];
  hardware.opengl.extraPackages32 = with pkgs.driversi686Linux; [
    intel-vaapi-driver
    libvdpau-va-gl
    intel-media-driver
  ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.bluetooth.enable = false;
  hardware.bluetooth.powerOnBoot = false;
}
