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

  cfg = config.${namespace}.editors.vscode;
in
{
  options.${namespace}.editors.vscode = with types; {
    enable = mkBoolOpt false "Whether or not to enable vscode.";

    extensions = mkOpt (listOf package) (
      with pkgs.vscode-extensions;
      [
        aaron-bond.better-comments
        twxs.cmake
        dracula-theme.theme-dracula
        golang.go
        james-yu.latex-workshop
        yzhang.markdown-all-in-one
        bbenoist.nix
        jnoortheen.nix-ide
        shd101wyy.markdown-preview-enhanced
        ms-python.python
        hashicorp.terraform
        ms-vscode.cpptools-extension-pack
        tomoki1207.pdf
        elixir-lsp.vscode-elixir-ls
        njpwerner.autodocstring
        tamasfe.even-better-toml
        usernamehw.errorlens
      ]
      ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "shopify-liquid";
          publisher = "sissel";
          version = "4.0.1";
          sha256 = "sha256-W4ZKGlc8MuyS46imasfPiIZlMDsnqwhdOUoKACv4DbQ=";
        }
        {
          name = "doxdocgen";
          publisher = "cschlosser";
          version = "1.4.0";
          sha256 = "sha256-InEfF1X7AgtsV47h8WWq5DZh6k/wxYhl2r/pLZz9JbU=";
        }
      ]
    ) "Extensions to install.";

    userSettings = mkOpt attrs {
      "files.autoSave" = "afterDelay";
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = "Dracula Theme Soft";
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nixd";
      "editor.fontLigatures" = true;
      "workbench.secondarySideBar.defaultVisibility" = "hidden";
      "chat.commandCenter.enabled" = false;
    } "User settings.";
  };

  config = mkIf cfg.enable {
    stylix.targets.vscode.enable = false;

    programs.vscode = {
      enable = true;

      profiles.default = {
        inherit (cfg) extensions userSettings;
      };
    };

    home.packages = with pkgs; [ nixd ];
  };
}
