{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    clang-tools
    clang
    gcc
    cmake
    ninja
    extra-cmake-modules
  ];
}
