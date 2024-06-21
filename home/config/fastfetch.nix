{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [ fastfetch ];

    file = {
      ".config/fastfetch/config.jsonc".text = builtins.toJSON {
        #       logo": { // https://github.com/fastfetch-cli/fastfetch/blob/71beb626c30c5755613d743d9349f7a95effbe6c/src/fastfetch.c#L900
        #   "type": "iterm",
        #   "source": "/home/carter/linux.png", // https://en.wikipedia.org/wiki/Linux#/media/File:Tux.svg
        #   "width": 30,
        #   "height": 14,
        #   "padding": {
        #     "top": 2,
        #     "left": 1,
        #     "right": 2
        #   };
        # };
        logo = {
          type = "kitty-direct";
          source = ../assets/nwixowos.png;
          width = 30;
          height = 14;
        };
        # logo = {
        #   type = "small";
        #   padding = {
        #     top = 1;
        #     right = 2;
        #   };
        # };
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        modules = [
          "title"
          "os"
          "host"
          "kernel"
          "uptime"
          "packages"
          "shell"
          # "display"
          # "de"
          # "wm"
          # "wmtheme"
          # "theme"
          # "icons"
          # "font"
          # "cursor"
          # "terminal"
          # "terminalfont"
          "cpu"
          "gpu"
          "memory"
          "swap"
          "disk"
          # "localip"
          # "battery"
          # "poweradapter"
          "locale"
          "break"
          "colors"
        ];
      };
    };
  };
}
