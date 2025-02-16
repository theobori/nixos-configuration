{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.cli.multiplexers.tmux;
in
{
  options.${namespace}.cli.multiplexers.tmux = with types; {
    enable = mkBoolOpt false "Whether or not to enable tmux multiplexer.";
    useMouse = mkBoolOpt false "Whether or not to enable the mouse.";
    prefix = mkOpt str "M-B" "Configure tmux prefix key.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      sesh
      lsof
    ];

    programs.tmux = {
      enable = true;
      shell = "${lib.getExe pkgs.fish}";
      terminal = "tmux-256color";
      historyLimit = 100000;
      sensibleOnTop = true;
      mouse = cfg.useMouse;

      plugins = with pkgs.tmuxPlugins; [
        better-mouse-mode
        tmux-thumbs
        {
          plugin = dracula;
          extraConfig = ''
            # dracula customizations
            set -g @dracula-plugins "time ram-usage battery"
            set -g @dracula-show-left-icon "><>"
            set -g @dracula-refresh-rate 3
            set -g @dracula-day-month true

            # Just prevention
            set -ug @dracula-show-right-sep
            set -ug @dracula-show-left-sep
            set -g @dracula-show-flags false
            set -g @dracula-border-contrast false
            set -g @dracula-show-timezone false
            set -g @dracula-show-powerline true
          '';
        }
      ];
      extraConfig = ''
        set -ag terminal-overrides ",xterm-256color:RGB"
        set-environment -g TMUX_PLUGIN_MANAGER_PATH '~/.local/share/tmux/plugins'

        # Easier reload of config
        bind r source-file ~/.config/tmux/tmux.conf

        # set-option -g status-position top

        set -g allow-passthrough on
        set -ga update-environment TERM
        set -ga update-environment TERM_PROGRAM

        bind-key x kill-pane

        # Rebind the tmux prefix
        unbind-key C-b
        set-option -g prefix ${cfg.prefix}
        bind-key ${cfg.prefix} send-prefix
      '';
    };
  };
}
