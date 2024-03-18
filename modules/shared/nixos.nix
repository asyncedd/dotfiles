{...}: {
  # dont change it unless you know what you doin'!
  system.stateVersion = "23.11";

  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.settings.trusted-users = ["root" "async"];

  # Optimise
  nix.gc = {
    automatic = true;
    dates = "weekly";
  };

  nix.optimise.automatic = true;
}
