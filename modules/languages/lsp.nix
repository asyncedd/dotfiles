{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # nix
    nil
    nixfmt

    # rust
    cargo
    rustc
    rustfmt
    rustPackages.clippy
    rust-analyzer

    # c
    clang-tools
    clang
    gcc
    cmake
    ninja
    extra-cmake-modules

    # toml
    taplo

    # web dev
    prettierd
    bun
    emmet-ls
    tailwindcss-language-server

    #css
    nodePackages.vscode-css-languageserver-bin

    # svelte
    nodePackages.svelte-language-server

    # lua
    stylua
    lua-language-server

    # java
    jdk17

    # markdown
    marksman
    markdown-oxide
  ];
}
