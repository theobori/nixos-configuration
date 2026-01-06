{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt enabled disabled;

  cfg = config.${namespace}.roles.gaming;
in
{
  options.${namespace}.roles.gaming = {
    enable = mkBoolOpt false "Enable gaming.";
  };

  config = mkIf cfg.enable {
    ${namespace} = {
      games = {
        teeworlds = enabled;
        taterclient-ddnet = disabled;
        supermariowar = enabled;
        vkquake = enabled;
        ninvaders = enabled;
        space-cadet-pinball = enabled;
        supertux = enabled;
        taisei = disabled; # Broken for the moment

        # Flatpaks
        # sober = enabled;
        # ricochlime = enabled;
        # playonlinux = enabled;
      };

      programs = {
        quake-injector = enabled;
      };
    };
  };
}
