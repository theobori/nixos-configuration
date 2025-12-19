{
  pkgs,
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.cli.programs.modern-unix;
in
{
  options.${namespace}.cli.programs.modern-unix = {
    enable = mkBoolOpt false "Whether or not to enable modern unix tools.";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      broot
      choose
      curlie
      chafa
      dogdns
      doggo
      duf
      delta
      dust
      dysk
      entr
      erdtree
      fd
      gdu
      gping
      grex
      hyperfine
      hexyl
      jqp
      jnv
      ouch
      silver-searcher
      procs
      tokei
      scc
      trash-cli
      tailspin
      gtrash
      ripgrep
      sd
      xcp
      yq-go
      viddy

      # go
      go
      golangci-lint
      air
      templ
      sqlc
      golines

      # go-task
      go-mockery
      gotestsum
    ];
  };
}
