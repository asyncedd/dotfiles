{ lib, pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_cachyos;

  hardware.cpu.intel.updateMicrocode = true;
boot = {
  kernelModules = ["kvm-intel"];
  kernelParams = [
    "i915.fastboot=1"
    "enable_gvt=1"
    "iommu=force"
  ];
};
  boot.initrd.kernelModules = ["i915"];
}
