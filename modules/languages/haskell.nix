{pkgs, ...}: {
  enviornment.systemPackages = with pkgs; [
    haskell-language-server
  ];
}
