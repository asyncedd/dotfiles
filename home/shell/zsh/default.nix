{
  pkgs,
  config,
  inputs,
  ...
}:
let
  eza = "${pkgs.eza}/bin/eza --group-directories-first --git --hyperlink --icons";
  # colors = config.lib.stylix.colors;
  omz = name: "source ${inputs.omz}/plugins/${name}/${name}.plugin.zsh";
in
{
  # home.packages = with pkgs; [ carapace ];
  # home.file.".zshlogin".source = ./.zlogin;
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
      ];
    };
    history = {
      size = 1024;
      save = 512;
      share = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };
    localVariables = {
      ZSH_AUTOSUGGEST_STRATEGY = [
        "history"
        "completion"
      ];
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND = "bg=default";
      HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND = "bg=default";
      HISTORY_SUBSTRING_SEARCH_FUZZY = "";
      HISTORY_SUBSTRING_SEARCH_PREFIXED = "";
    };
    plugins = [
      {
        name = "powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
      {
        name = "fzf-tab";
        src = "${pkgs.zsh-fzf-tab}/share/fzf-tab";
      }
      {
        name = "zsh-autosuggestions";
        src = "${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions";
        file = "zsh-autosuggestions.zsh";
      }
      {
        name = "zsh-history-substring-search";
        src = "${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search";
        file = "zsh-history-substring-search.zsh";
      }
      {
        name = "p10k-config";
        src = ./.;
        file = "p10k.zsh";
      }
    ];
    initExtraFirst = ''
      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
    '';
    initExtra = ''
       bindkey '^[[a' history-substring-search-up
       bindkey '^[[b' history-substring-search-down
       bindkey "$terminfo[kcuu1]" history-substring-search-up
       bindkey "$terminfo[kcud1]" history-substring-search-down

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
       zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
       # preview directory's content with exa when completing cd
       zstyle ':fzf-tab:complete:cd:*' fzf-preview '${config.programs.zsh.shellAliases.ls} --color=always $realpath'
       zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ''${(Q)realpath}'
       zstyle ':completion:*:descriptions' format '[%d]'
       # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
       zstyle ':completion:*' menu no
       # switch group using `<` and `>`
       zstyle ':fzf-tab:*' switch-group '<' '>'
       zstyle ':completion:*' menu select

       path+=('/home/async/.cargo/bin')
       export PATH
       ${omz "cp"}
       ${omz "git"}

      chpwd_functions+=(chpwd_cdls)
      function chpwd_cdls() {
      	if [[ -o interactive ]]; then
      		emulate -L zsh
      			${config.programs.zsh.shellAliases.ls}
      			fi
      }
    '';
    shellAliases = {
      ll = "${eza} -l";
      lla = "${eza} -al -TL 1";
      ".." = "cd ..";
      ls = "${eza} -TL 1";
      la = "${eza} -a -TL 1";
      lt = "${eza} -a";
      tree = "${eza} --tree";
      cat = "bat";
    };
  };
}
