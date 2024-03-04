{
  config,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    neofetch
    eza
    zsh-history-substring-search
    zsh-vi-mode
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 1024;
      save = 512;
      share = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };
    initExtra = ''
      compinit

      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh

      ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
      bindkey '^[[Z' reverse-menu-complete
      bindkey '^[OA' history-substring-search-up
      bindkey '^[[A' history-substring-search-up
      bindkey '^[OB' history-substring-search-down
      bindkey '^[[B' history-substring-search-down

      path+=('/home/async/.cargo/bin')
      export PATH

      zstyle ':completion:*' menu select

      unsetopt menu_complete
      unsetopt flowcontrol
      unsetopt BEEP

      setopt prompt_subst
      setopt always_to_end
      setopt append_history
      setopt auto_menu
      setopt complete_in_word
      setopt extended_history
      setopt hist_expire_dups_first
      setopt hist_ignore_dups
      setopt hist_ignore_space
      setopt hist_verify
      setopt inc_append_history

      alias ls="eza -lo --hyperlink --git-repos -TL 1 --tree --icons"
      alias la="eza -lao --hyperlink --git-repos -TL 1 --tree --icons"
      alias tree="eza -lao --hyperlink --git-repos --tree --icons"
      alias sudo="doas"

      chpwd_functions+=(chpwd_cdls)
      function chpwd_cdls() {
        if [[ -o interactive ]]; then
          emulate -L zsh
          ls
        fi
      }
    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
    };
  };
}
