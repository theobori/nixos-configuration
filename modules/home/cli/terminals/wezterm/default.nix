{ config, lib, ... }:
let
  cfg = config.cli.terminals.wezterm;
in
{
  options.cli.terminals.wezterm = {
    enable = lib.mkEnableOption "enable wezterm terminal emulator";
  };

  config = lib.mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = builtins.readFile ./wezterm.lua;
    };
  };
}
