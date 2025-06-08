{
  config,
  pkgs,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace})
    mkBoolOpt
    enabled
    disabled
    mkOpt
    ;

  cfg = config.${namespace}.hardware.audio;
in
{
  options.${namespace}.hardware.audio = with types; {
    enable = mkBoolOpt false "Enable or disable hardware audio support.";
    extraConfig = mkOpt attrs {
      pipewire = {
        "99-disable-x11-bell" = {
          "context.properties" = {
            "module.x11.bell" = false;
          };
        };
      };
    } "PipeWire service extra configuration.";
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

      inherit (cfg) extraConfig;
    };
    programs.noisetorch = enabled;

    environment.systemPackages = with pkgs; [ pulsemixer ];
  };
}
