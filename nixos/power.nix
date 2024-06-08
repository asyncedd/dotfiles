{
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];
  services.system76-scheduler.settings.cfsProfiles.enable = true;

  programs.auto-cpufreq = {
    enable = true;
    settings = {
      charger = {
        governor = "performance";
        turbo = "auto";
      };

      battery = {
        governor = "powersave";
        turbo = "auto";
      };
    };
  };

  services.power-profiles-daemon.enable = lib.mkForce false;
  powerManagement.powertop.enable = lib.mkForce true;
  services.thermald.enable = true;
  services.tlp.enable = lib.mkForce false;
}
