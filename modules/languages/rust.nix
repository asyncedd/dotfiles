{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    cargo
    rustc
    rustfmt
    rustPackages.clippy
    rust-analyzer
  ];
}
