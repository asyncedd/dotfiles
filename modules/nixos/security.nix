{
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.ags = {};
    pam.services.swaylock = {};
    pam.services.hyprlock = {};
  };
}
