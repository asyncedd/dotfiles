{
  pkgs,
  config,
  inputs,
  ...
}: let
  eza = "${pkgs.eza}/bin/eza --group-directories-first --git --hyperlink --icons";
  colors = config.lib.stylix.colors;
  omz = name: "source ${inputs.omz}/plugins/${name}/${name}.plugin.zsh";
in {
  home.packages = with pkgs; [
    carapace
  ];
  home.file.".zshlogin".source = ./.zlogin;
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
    # completionInit = ''
    #   autoload -Uz compinit; compinit -C
    #   (autoload -Uz compinit; compinit &)
    # '';
    # initExtraBeforeCompInit = ''
    #   fpath+=(${pkgs.zsh-completions}/share/zsh/site-functions)
    # '';
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        source ${./p10k.zsh}
        source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.zsh

      	ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_NEX
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND=bg=default
        HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND=bg=default
      	bindkey '^[[Z' reverse-menu-complete

      	path+=('/home/async/.cargo/bin')
      	export PATH

        # ZVM_VI_HIGHLIGHT_FOREGROUND=#${colors.base00}
        # ZVM_VI_HIGHLIGHT_BACKGROUND=#${colors.base02}
        #
        # ${omz "common-aliases"}
        ${omz "cp"}
        ${omz "git"}
        # autoload colors
        # ${omz "colored-man-pages"}
        # ${omz "command-not-found"}

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
        zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
        # preview directory's content with exa when completing cd
        zstyle ':fzf-tab:complete:cd:*' fzf-preview '${config.programs.zsh.shellAliases.ls} --color=always $realpath'
        zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ''${(Q)realpath}'
                zstyle ':completion:*:descriptions' format '[%d]'
        # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
        zstyle ':completion:*' menu no
        # switch group using `<` and `>`
        zstyle ':fzf-tab:*' switch-group '<' '>'

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

      export SUDO_PROMPT=$'Password for ->\033[32;05;16m %u\033[0m  '
      export FZF_DEFAULT_OPTS="
       --color fg:#${colors.base04}
       --color fg+:#${colors.base06}
       --color bg:#${colors.base00}
       --color bg+:#${colors.base01}
       --color hl:#${colors.base0D}
       --color hl+:#${colors.base0D}
       --color info:#${colors.base0A}
       --color marker:#${colors.base0C}
       --color prompt:#${colors.base0A}
       --color spinner:#${colors.base0C}
       --color pointer:#${colors.base0C}
       --color header:#${colors.base0D}
       --color preview-fg:#${colors.base0D}
       --color preview-bg:#${colors.base01}
       --color gutter:#${colors.base00}
       --color border:#${colors.base0B}
       --border
       --prompt 'λ '
       --pointer ''
       --marker ''
      "
    '';
    shellAliases = {
      ll = "${eza} -l";
      lla = "${eza} -al -TL 1";
      ".." = "cd ..";
      ls = "${eza} -TL 1";
      la = "${eza} -a -TL 1";
      lt = "${eza} -a";
      tree = "${eza} -a";
      cat = "bat";
    };
  };
}
