{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled disabled;

  cfg = config.${namespace}.hardware.audio;
in
{
  options.${namespace}.hardware.audio = {
    enable = mkBoolOpt false "Enable or disable hardware audio support.";
  };

  config = mkIf cfg.enable {
    services.pulseaudio = disabled;
    security.rtkit = enabled;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse = enabled;
      jack = enabled;
      wireplumber = enabled;
    };
    programs.noisetorch = enabled;

    environment.systemPackages = with pkgs; [ pulsemixer ];
  };
}
