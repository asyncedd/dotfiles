{
  pkgs,
  config,
  ...
}: let
  eza = "${pkgs.eza}/bin/eza --group-directories-first --git --hyperlink --icons";
in {
  home.packages = with pkgs; [
    carapace
    zsh-vi-mode
  ];

  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets" "pattern" "cursor" "regexp" "root" "line"];
    };
    history = {
      size = 1024;
      save = 512;
      share = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };
    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = ["history" "completion"];
    };
    # initExtraBeforeCompInit = ''
    #   fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
    # '';
    initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${./p10k.zsh}
      	source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.zsh
        source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.zsh

      	ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=default
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=bg=default
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

        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down

        # disable sort when completing `git checkout`
        zstyle ':completion:*:git-checkout:*' sort false
        # set list-colors to enable filename colorizing
        zstyle ':completion:*' list-colors ''${(s.:.)EZA_COLORS}
        # preview directory's content with exa when completing cd
        zstyle ':fzf-tab:complete:cd:*' fzf-preview '${config.programs.zsh.shellAliases.ls} --color=always $realpath'
        zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ''${(Q)realpath}'

        zstyle -d ':completion:*' format
      	bindkey "^[[1;5C" forward-word

      	chpwd_functions+=(chpwd_cdls)
      	function chpwd_cdls() {
      		if [[ -o interactive ]]; then
      			emulate -L zsh
      				${config.programs.zsh.shellAliases.ls}
      				fi
      	}

      source <(${pkgs.carapace}/bin/carapace _carapace)

      ${pkgs.krabby}/bin/krabby random
    '';
    shellAliases = {
      ll = "ls -l";
      ".." = "cd ..";
      ls = "${eza} -TL 1";
      la = "${eza} -a -TL 1";
      tree = "${eza} -a";
      cat = "bat";
    };
  };
}
