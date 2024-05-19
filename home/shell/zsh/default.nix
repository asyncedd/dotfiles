{pkgs, ...}: {
  home.packages = with pkgs; [
    eza
    bat
    carapace
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
    historySubstringSearch = {
      searchUpKey = ''        ^[[A' history-substring-search-up
              bindkey "$terminfo[kcuu1]" history-substring-search-up
              bindkey -M vicmd 'k' history-substring-search-up
              bindkey -M emacs '^P'';
      searchDownKey = ''        ^[[B' history-substring-search-down
              bindkey "$terminfo[kcud1]" history-substring-search-down
              bindkey -M vicmd 'j' history-substring-search-down
              bindkey -M emacs '^N'';
      enable = true;
    };
    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = ["history" "completion"];
    };
    initExtra = ''
      	source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh

      	ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
      	bindkey '^[[Z' reverse-menu-complete

      	path+=('/home/async/.cargo/bin')
      	export PATH

      	zstyle ':completion:*' menu select

      	unsetopt menu_complete
      	unsetopt flowcontrol
      	unsetopt BEEP

        setopt INTERACTIVE_COMMENTS
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

        # disable sort when completing `git checkout`
        zstyle ':completion:*:git-checkout:*' sort false
        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors ''${(s.:.)EZA_COLORS}
        # preview directory's content with exa when completing cd
        zstyle -d ':completion:*' format
        zstyle ':completion:*:descriptions' format '[%d]'
      	bindkey "^[[1;5C" forward-word

      	chpwd_functions+=(chpwd_cdls)
      	function chpwd_cdls() {
      		if [[ -o interactive ]]; then
      			emulate -L zsh
      				eza -lo --hyperlink --git-repos -TL 1 --tree --icons
      				fi
      	}

      source <(${pkgs.carapace}/bin/carapace _carapace)

      ${pkgs.krabby}/bin/krabby random
    '';
    completionInit = ''
      compinit
    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      ls = "eza -lo --hyperlink --git-repos -TL 1 --tree --icons";
      la = "eza -lao --hyperlink --git-repos -TL 1 --tree --icons";
      tree = "eza -lao --hyperlink --git-repos --tree --icons";
      cat = "bat";
    };
  };
}
