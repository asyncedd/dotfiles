{...}: {
  programs.nushell = {
    enable = true;
    extraConfig = ''
         let carapace_completer = {|spans|
           carapace $spans.0 nushell $spans | from json
         }
         $env.config = {
           show_banner: false,
           completions: {
             case_sensitive: false # case-sensitive completions
             quick: true    # set to false to prevent auto-selecting completions
             partial: true    # set to false to prevent partial filling of the prompt
             algorithm: "fuzzy"    # prefix or fuzzy
             external: {
               # set to false to prevent nushell looking into $env.PATH to find more suggestions
               enable: true
               # set to lower can improve completion performance at the cost of omitting some options
               max_results: 100
               completer: $carapace_completer # check 'carapace_completer'
             }
           }
           edit_mode: vi
           cursor_shape: {
             emacs: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (line is the default)
             vi_insert: line # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (block is the default)
             vi_normal: block # block, underscore, line, blink_block, blink_underscore, blink_line, inherit to skip setting cursor shape (underscore is the default)
           }
           use_grid_icons: true
           float_precision: 2 # the precision for displaying floats in tables
           buffer_editor: "" # command that will be used to edit the current line buffer with ctrl+o, if unset fallback to $env.EDITOR and $env.VISUAL
           use_ansi_coloring: true
           bracketed_paste: true # enable bracketed paste, currently useless on windows
           shell_integration: false # enables terminal shell integration. Off by default, as some terminals have issues with this.
           render_right_prompt_on_last_line: false # true or false to enable or disable right prompt to be rendered on last line of the prompt.
           use_kitty_protocol: true
         }
         $env.PATH = ($env.PATH |
         split row (char esep) |
         prepend /home/myuser/.apps |
         append /usr/bin/env
         )
    '';
    shellAliases = {
      vi = "hx";
      vim = "hx";
      nano = "hx";
    };
  };

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;
}
