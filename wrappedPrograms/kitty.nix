# Kitty terminal — Ashen Keep (Dark Souls) palette
# Cursor trail is preserved AND enhanced: higher decay range for "jelly" feel.
{self, ...}: {
  flake.nixosModules.kitty = {pkgs, lib, ...}: {
    programs.kitty = {
      enable = true;
      font = { name = "JetBrainsMono Nerd Font"; size = 13; };

      settings = {
        # ── JELLY CURSOR TRAIL ──────────────────────────────────
        # Increased trail count + wider decay window = fluid gel motion
        cursor_trail                 = 3;        # was 1, now 3 ghost trails
        cursor_trail_decay           = "0.05 0.4"; # slower fade = more jelly
        cursor_trail_start_threshold = 2;        # triggers even on slow movement
        shell_integration            = "no-cursor";
        cursor_shape                 = "beam";
        cursor_blink_interval        = "0.5";
        cursor_stop_blinking_after   = "15.0";
        cursor_beam_thickness        = "2.0";

        # ── Ashen Keep palette ───────────────────────────────────
        background           = "#0a0b0e"; # Abyss
        foreground           = "#b0b8c8"; # Pale Ash
        cursor               = "#c49a30"; # Bonfire Gold
        cursor_text_color    = "#0a0b0e";
        selection_background = "#1c1f28"; # Dark Ash
        selection_foreground = "#c8d0e0"; # Moonstone

        active_tab_foreground   = "#c49a30"; # Bonfire Gold
        active_tab_background   = "#1c1f28"; # Dark Ash
        inactive_tab_foreground = "#6a7088"; # Faded Rune
        inactive_tab_background = "#12141a"; # Cinder

        # base16 slots
        color0  = "#0a0b0e"; color8  = "#2c3040";
        color1  = "#a83a3a"; color9  = "#a83a3a"; # Blood Ember
        color2  = "#5a8a58"; color10 = "#5a8a58"; # Moss on Ruins
        color3  = "#d4b44e"; color11 = "#d4b44e"; # Soul Ember
        color4  = "#6070a8"; color12 = "#6070a8"; # Lothric Blue
        color5  = "#7a5090"; color13 = "#7a5090"; # Phantom Violet
        color6  = "#4a7e96"; color14 = "#4a7e96"; # Frigid Steel
        color7  = "#c8d0e0"; color15 = "#e0e6f0"; # Moonstone / Phantom White

        # ── Window ───────────────────────────────────────────────
        window_padding_width    = 8;
        hide_window_decorations = "yes";
        background_opacity      = "0.93";

        # ── Misc ─────────────────────────────────────────────────
        confirm_on_close     = "never";
        enable_audio_bell    = "no";
        tab_bar_style        = "powerline";
        allow_remote_control = "yes";
      };

      keybindings = {
        "alt+1"         = "goto_tab 1";
        "alt+2"         = "goto_tab 2";
        "alt+3"         = "goto_tab 3";
        "alt+4"         = "goto_tab 4";
        "alt+5"         = "goto_tab 5";
        "ctrl+shift+w"  = "close_tab";
        "ctrl+t"        = "new_tab_with_cwd";
        "ctrl+shift+t"  = "new_tab";
      };
    };
  };
}
