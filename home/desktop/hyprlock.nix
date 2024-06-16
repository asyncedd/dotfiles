{ osConfig, ... }: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = false;
        hide_cursor = false;
        no_fade_in = false;
      };

      background = {
        monitor = "";
        path = "${osConfig.stylix.image}";
        color = "rgba(0, 0, 0, 0.5)";
        blur_passes = 3;
        contrast = 0.8916;
        brightness = 0.8172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0.0;
      };

      input-field = {
        monitor = "";

        size = "300, 50";
        outline_thickness = 0;

        dots_spacing = 0.3;
        dots_center = true;
        placeholder_text = "<i>Input Password...</i>";
        fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
      };

      label = {
        monitor = "";
        text = "<b><big>$TIME</big></b>";
        font_family = "New York";
        font_size = 50;

        position = "0, 80";
        valign = "center";
        halign = "center";
      };
    };
  };
}
