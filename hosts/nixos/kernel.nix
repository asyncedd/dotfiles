{
  boot = {
    kernelModules = ["kvm-intel"];
    kernelParams = [
      "enable_gvt=1"
      "iommu=force"
    ];
  };
}
