{...}: {
  security.doas.enable = true;
  security.sudo.enable = false;
  # Configure doas
  security.doas.extraRules = [
    {
      users = ["async"];
      keepEnv = true;
      persist = true;
    }
  ];
}
