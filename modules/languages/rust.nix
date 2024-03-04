{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    unstable.cargo
    unstable.rustc
    rustfmt
    rustPackages.clippy
    rust-analyzer
  ];
}
