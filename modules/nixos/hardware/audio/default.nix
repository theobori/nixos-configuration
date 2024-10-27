{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.hardware.audio;
in
{
  options.hardware.audio = {
    enable = lib.mkEnableOption "Enable or disable hardware audio support";
  };

  config = lib.mkIf cfg.enable {
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };
    programs.noisetorch.enable = true;

    environment.systemPackages = with pkgs; [ pulsemixer ];
  };
}
