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

  cfg = config.${namespace}.editors.vscode;
in
{
  options.${namespace}.editors.vscode = {
    enable = mkBoolOpt false "Whether or not to enable vscode.";
  };

  config = mkIf cfg.enable {
    stylix.targets.vscode.enable = false;

    programs.vscode = {
      enable = true;

      userSettings = {
        "files.autoSave" = "afterDelay";
        "window.menuBarVisibility" = "toggle";
        "workbench.colorTheme" = "Dracula Theme Soft";
      };

      extensions =
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
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "doxdocgen";
            publisher = "cschlosser";
            version = "1.4.0";
            sha256 = "sha256-InEfF1X7AgtsV47h8WWq5DZh6k/wxYhl2r/pLZz9JbU=";
          }
        ];
    };
  };
}
