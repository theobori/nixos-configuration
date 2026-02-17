{
  config,
  lib,
  namespace,
  ...
}:
let
  inherit (lib) mkIf types;
  inherit (lib.${namespace}) mkBoolOpt mkOpt;

  cfg = config.${namespace}.browsers.nyxt;
in
{
  options.${namespace}.browsers.nyxt = with types; {
    enable = mkBoolOpt false "Enable nyxt browser.";
    config = mkOpt lines ''
      (define-configuration input-buffer
        ((override-map
          (let ((map (make-keymap "override-map")))
            (define-key map "M-x" 'execute-command)))))

       (define-configuration buffer
         ((default-modes
           (pushnew 'nyxt/mode/emacs:emacs-mode %slot-value%))))

       (define-configuration web-buffer
         ((default-modes
           (pushnew 'nyxt/mode/reduce-tracking:reduce-tracking-mode %slot-value%))))

       (defvar *my-search-engines*
         (list
          '("python3" "https://docs.python.org/3/search.html?q=~a" "https://docs.python.org/3")
          '("DuckDuckGo" "https://duckduckgo.com/ac/?q=~a" "https://duckduckgo.com"))
         "List of search engines.")

       (define-configuration context-buffer
         "Go through the search engines above and make-search-engine out of them."
         ((search-engines
           (append
            (mapcar (lambda (engine) (apply 'make-search-engine engine))
                    *my-search-engines*)
            %slot-default%))))

       (nyxt::load-lisp "${./statusline.lisp}")
       (nyxt::load-lisp "${./stylesheet.lisp}")
    '' "Manage the Nyxt configuration.";
  };

  config = mkIf cfg.enable {
    programs.nyxt = {
      enable = true;
      inherit (cfg) config;
    };
  };
}
