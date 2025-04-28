{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.${namespace}) mkBoolOpt;

  cfg = config.${namespace}.editors.emacs.packages.ligature;
in
{
  options.${namespace}.editors.emacs.packages.ligature = {
    enable = mkBoolOpt false "Whether or not to enable the emacs Ligature package.";
  };

  config = mkIf cfg.enable {
    programs.emacs = {
      extraPackages = (epkgs: [ epkgs.ligature ]);
      extraConfig = ''
        ;; This assumes you've installed the package via MELPA.
        (use-package ligature
          :config
          ;; Enable the "www" ligature in every possible major mode
          (ligature-set-ligatures 't '("www"))
          ;; Enable traditional ligature support in eww-mode, if the
          ;; `variable-pitch' face supports it
          (ligature-set-ligatures 'eww-mode '("ff" "fi" "ffi"))
          ;; Enable all Cascadia Code ligatures in programming modes
          (ligature-set-ligatures 'prog-mode '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                               ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                               "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                               "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                               "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                               "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                               "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                               "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                               ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                               "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                               "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                               "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                               "\\\\" "://"))
          ;; Enables ligature checks globally in all buffers. You can also do it
          ;; per mode with `ligature-mode'.
          (global-ligature-mode t))
      '';
    };
  };
}
