{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.cli.terminals.kitty;
in
{
  options.${namespace}.cli.terminals.kitty = with types; {
    enable = mkBoolOpt false "Enable kitty terminal emulator.";
    extraConfig = mkOpt str ''
      window_padding_width 6
      cursor_shape block
      cursor_blink_interval 0

      # Mapping GNU Emacs multiple keys sequence
      map ctrl+; send_text all \x1b[27;5;59~
      map ctrl+' send_text all \x1b[27;5;39~
      map ctrl+( send_text all \x1b[27;5;40~
      map ctrl+) send_text all \x1b[27;5;41~
    '' "Manage the Kitty extra configuration.";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;

      inherit (cfg) extraConfig;
      shellIntegration.mode = "no-cursor";
    };
  };
}
