{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];

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

  services.power-profiles-daemon.enable = false;
  powerManagement.powertop.enable = lib.mkForce true;
  services.thermald.enable = true;
  services.system76-scheduler.settings.cfsProfiles.enable = true;
  services.tlp.enable = false;
  # programs.tlp.enable = false;
}
