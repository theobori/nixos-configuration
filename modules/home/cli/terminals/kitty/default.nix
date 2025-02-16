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
