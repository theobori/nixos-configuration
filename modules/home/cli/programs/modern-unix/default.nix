{
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.cli.programs.modern-unix;
in
{
  options.cli.programs.modern-unix = {
    enable = lib.mkEnableOption "Whether or not to enable modern unix tools";
  };

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      broot
      choose
      curlie
      chafa
      dogdns
      doggo
      duf
      delta
      du-dust
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
      gotools

      # go-task
      go-mockery
      gotestsum
    ];
  };
}