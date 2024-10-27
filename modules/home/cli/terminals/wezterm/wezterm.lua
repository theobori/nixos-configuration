local wezterm = require 'wezterm'

return {
    color_scheme = "Dracula",
    tab_bar_at_bottom = false,
    use_fancy_tab_bar = false,
    window_decorations = "RESIZE",
    window_background_opacity = 1.0,
    hide_tab_bar_if_only_one_tab = true,
    default_prog = { "fish" },
    font = wezterm.font_with_fallback {
        "MonoLisa Nerd Font",
		"Fira Code",
		"Noto Color Emoji",
    },
    font_size = 11,
    warn_about_missing_glyphs = false,
    initial_rows = 34,
    initial_cols = 113,
    front_end = "WebGpu",
    enable_wayland = false
}
