{ pkgs, lib, config, ...}:
with lib; let
  cfg = config.modules.tmux;
in
{
  options.modules.tmux = { enable = mkEnableOption "tmux"; };
  config = mkIf cfg.enable {
    programs.tmux = {
      enable = true;
      clock24 = true;
      newSession = true;
      terminal = "xterm-256color";
      plugins = [
        pkgs.tmuxPlugins.resurrect
        pkgs.tmuxPlugins.continuum
        pkgs.tmuxPlugins.sensible
      ];
      extraConfig = ''
        set -g mouse on
        bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'copy-mode -e; send-keys -M'"
        bind -n C-k clear-history

        set -g default-terminal "screen-256color"
        set -ga terminal-overrides ",*256col*:Tc"
        set-option -g default-terminal "xterm-256color"
        set-option -ga terminal-overrides ',xterm-256color:Tc'

        # copy paste
        bind P paste-buffer
        bind-key -T copy-mode-vi v send-keys -X begin-selection
        bind-key -T copy-mode-vi y send-keys -X copy-selection
        bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

        bind -T copy-mode-vi y send -X copy-pipe-and-cancel "xclip -sel clip -i"

        set -g @resurrect-strategy-nvim 'session'
        set -g @continuum-restore 'on'

        #+----------------+
        #+ Plugin Support +
        #+----------------+
        #+--- tmux-prefix-highlight ---+
        set -g @prefix_highlight_fg #292D3E
        set -g @prefix_highlight_bg #89DDFF

        #+---------+
        #+ Options +
        #+---------+
        set -g status-interval 1
        set -g status on

        #+--------+
        #+ Status +
        #+--------+
        #+--- Layout ---+
        set -g status-justify left

        #+--- Colors ---+
        set -g status-bg colour235
        set -g status-fg default
        set -g status-attr default

        #+-------+
        #+ Panes +
        #+-------+
        set -g pane-border-bg #292D3E
        set -g pane-border-fg #292D3E
        set -g pane-active-border-fg #3E4452
        set -g display-panes-colour #292D3E
        set -g display-panes-active-colour #3E4452

        #+------------+
        #+ Clock Mode +
        #+------------+
        setw -g clock-mode-colour #89DDFF

        #+----------+
        #+ Messages +
        #+---------+
        set -g message-fg #89DDFF
        set -g message-bg #3E4452
        set -g message-command-fg #89DDFF
        set -g message-command-bg #3E4452

        #+----------------+
        #+ Plugin Support +
        #+----------------+
        #+--- tmux-prefix-highlight ---+
        set -g @prefix_highlight_output_prefix "#[fg=#89DDFF]#[bg=default]#[nobold]#[noitalics]#[nounderscore]#[bg=#89DDFF]#[fg=default]"
        set -g @prefix_highlight_output_suffix ""
        set -g @prefix_highlight_show_copy_mode 'on'
        set -g @prefix_highlight_copy_mode_attr "fg=#ffcb6b,bg=default,bold"

        #+--------+
        #+ Status +
        #+--------+
        #+--- Bars ---+
        set -g status-left "#[fg=#292D3E,bg=#ffcb6b,bold] #S #[fg=#ffcb6b,bg=default,nobold,noitalics,nounderscore]"
        set -g status-right "#{prefix_highlight}#[fg=#3E4452,bg=default,nobold,noitalics,nounderscore]#[fg=#c792ea,bg=#3E4452] %Y-%m-%d #[fg=#c792ea,bg=#3E4452,nobold,noitalics,nounderscore]#[fg=#c792ea,bg=#3E4452] %H:%M #[fg=#c792ea,bg=#3E4452,nobold,noitalics,nounderscore]#[fg=#292D3E,bg=#c792ea,bold] #H "

        #+--- Windows ---+
        set -g window-status-format "#[fg=colour235,bg=#3E4452,nobold,noitalics,nounderscore] #[fg=#c792ea,bg=#3E4452]#I #[fg=#c792ea,bg=#3E4452,nobold,noitalics,nounderscore] #[fg=#c792ea,bg=#3E4452]#W #F #[fg=#3E4452,bg=default,nobold,noitalics,nounderscore]"
        set -g window-status-current-format "#[fg=colour235,bg=#c792ea,nobold,noitalics,nounderscore] #[fg=#292D3E,bg=#c792ea]#I #[fg=#292D3E,bg=#c792ea,nobold,noitalics,nounderscore] #[fg=#292D3E,bg=#c792ea]#W #F #[fg=#c792ea,bg=default,nobold,noitalics,nounderscore]"
        set -g window-status-separator ""
        set -g monitor-activity off

      '';
    };
  };
}
