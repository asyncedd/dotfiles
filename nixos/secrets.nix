{
  sops.defaultSopsFile = ../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/async/.config/sops/age/keys.txt";
  sops.secrets."nix/access_tokens" = {};
}
