{...}: {
  programs.fzf = {
    enable = true;
    # fuzzyCompletion = true;
    enableZshIntegration = true;
    defaultOptions = [
      "--border=\"rounded\""
      "--border-label=\"\""
      "--preview-window=\"border-rounded\""
      "--prompt=\"\""
      "--marker=\">\""
      "--pointer=\">\""
      "--separator=\"─\""
      "----scrollbar=\"│\""
    ];
  };
}
