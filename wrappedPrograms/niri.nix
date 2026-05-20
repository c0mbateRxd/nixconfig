# Niri compositor — Ashen Keep
# All keybinds from your original niri.nix are preserved.
{self, inputs, ...}: {
  flake.nixosModules.niri = {pkgs, lib, config, ...}: let
    # Named workspaces for Roman numeral display in Quickshell
    workspaceNames = ["I" "II" "III" "IV" "V"];
  in {
    programs.niri = {
      enable = true;
      settings = {
        prefer-no-csd = true;

        input = {
          keyboard = {
            xkb.layout = "us";
            repeat-delay = 300;
            repeat-rate  = 35;
            numlock      = true;
          };
          touchpad = {
            tap            = true;
            natural-scroll = true;
            dwt            = true;
          };
          focus-follows-mouse.max-scroll-amount = "0%";
        };

        # Spawn at startup
        spawn-at-startup = [
          { command = ["quickshell"]; }
          { command = ["swaybg" "-i" "${self.wallpaper}" "-m" "fill"]; }
          { command = ["xwayland-satellite"]; }
          { command = ["dunst"]; }
        ];

        # Layout — 8px gaps, Bonfire Gold focus ring
        layout = {
          gaps = 8;
          center-focused-column = "never";
          preset-column-widths = [
            {proportion = 0.33333;}
            {proportion = 0.5;}
            {proportion = 0.66667;}
          ];
          default-column-width.proportion = 0.5;
          focus-ring = {
            enable = true;
            width = 2;
            active-color   = "#c49a30ff"; # Bonfire Gold
            inactive-color = "#2c3040aa"; # Grave Iron
          };
          border.enable = false;
        };

        # Named workspaces — maps to Roman numerals in Quickshell
        workspaces = {
          "I"   = {};
          "II"  = {};
          "III" = {};
          "IV"  = {};
          "V"   = {};
        };

        # Window rules
        window-rules = [
          { matches = [{app-id = "kitty";}]; draw-border-with-background = false; }
          # Floating windows
          { matches = [{title = "nmtui";}]; open-floating = true; }
          { matches = [{app-id = "blueman-manager";}]; open-floating = true; }
          { matches = [{app-id = "pavucontrol";}]; open-floating = true; }
        ];

        # ── Binds ─────────────────────────────────────────────────
        binds = with config.lib.niri.actions; let
          sh = lib.getExe pkgs.bash;
          wpctl = "${pkgs.wireplumber}/bin/wpctl";
          brightnessctl = lib.getExe pkgs.brightnessctl;
          playerctl = lib.getExe pkgs.playerctl;
          grim = lib.getExe pkgs.grim;
          slurp = lib.getExe pkgs.slurp;
          wlcopy = "${pkgs.wl-clipboard}/bin/wl-copy";
        in {
          # Essentials
          "Mod+Return".action = spawn "kitty";
          "Mod+D".action      = spawn "rofi" "-show" "drun" "-show-icons";
          "Mod+O".action      = toggle-overview;
          "Mod+Q".action      = close-window;
          "Mod+Shift+E".action = quit;
          "Ctrl+Alt+Delete".action = quit;
          "Mod+Shift+P".action = power-off-monitors;
          "Alt+F4".action = spawn "wlogout" "-b" "2";

          # Screenshots — your exact binds
          "Print".action       = screenshot;
          "Ctrl+Print".action  = screenshot-screen;
          "Alt+Print".action   = screenshot-window;
          # To clipboard
          "Mod+Shift+S".action = spawn sh "-c" ''${grim} -g "$(${slurp} -w 0)" - | ${wlcopy}'';
          "Mod+Ctrl+S".action  = spawn sh "-c" ''${grim} -l 0 - | ${wlcopy}'';

          # Focus
          "Mod+Left".action  = focus-column-left;
          "Mod+Down".action  = focus-window-down;
          "Mod+Up".action    = focus-window-up;
          "Mod+Right".action = focus-column-right;
          "Mod+H".action     = focus-column-left;
          "Mod+J".action     = focus-window-down;
          "Mod+K".action     = focus-window-up;
          "Mod+L".action     = focus-column-right;

          # Move windows
          "Mod+Ctrl+Left".action  = move-column-left;
          "Mod+Ctrl+Down".action  = move-window-down;
          "Mod+Ctrl+Up".action    = move-window-up;
          "Mod+Ctrl+Right".action = move-column-right;
          "Mod+Ctrl+H".action     = move-column-left;
          "Mod+Ctrl+J".action     = move-window-down;
          "Mod+Ctrl+K".action     = move-window-up;
          "Mod+Ctrl+L".action     = move-column-right;

          # Workspace movement
          "Mod+Shift+Page_Down".action = move-workspace-down;
          "Mod+Shift+Page_Up".action   = move-workspace-up;
          "Mod+Shift+U".action         = move-workspace-down;
          "Mod+Shift+I".action         = move-workspace-up;

          # Scroll
          "Mod+WheelScrollDown".action      = { focus-workspace-down = {}; cooldown-ms = 150; };
          "Mod+WheelScrollUp".action        = { focus-workspace-up   = {}; cooldown-ms = 150; };
          "Mod+Ctrl+WheelScrollDown".action = { move-column-to-workspace-down = {}; cooldown-ms = 150; };
          "Mod+Ctrl+WheelScrollUp".action   = { move-column-to-workspace-up   = {}; cooldown-ms = 150; };
          "Mod+WheelScrollRight".action      = focus-column-right;
          "Mod+WheelScrollLeft".action       = focus-column-left;
          "Mod+Ctrl+WheelScrollRight".action = move-column-right;
          "Mod+Ctrl+WheelScrollLeft".action  = move-column-left;

          # Named workspace focus
          "Mod+1".action = focus-workspace "I";
          "Mod+2".action = focus-workspace "II";
          "Mod+3".action = focus-workspace "III";
          "Mod+4".action = focus-workspace "IV";
          "Mod+5".action = focus-workspace "V";
          "Mod+Shift+1".action = move-column-to-workspace "I";
          "Mod+Shift+2".action = move-column-to-workspace "II";
          "Mod+Shift+3".action = move-column-to-workspace "III";
          "Mod+Shift+4".action = move-column-to-workspace "IV";
          "Mod+Shift+5".action = move-column-to-workspace "V";

          # Column/window ops — your exact binds
          "Mod+BracketLeft".action  = consume-or-expel-window-left;
          "Mod+BracketRight".action = consume-or-expel-window-right;
          "Mod+Period".action       = expel-window-from-column;

          # Resize
          "Mod+R".action       = switch-preset-column-width;
          "Mod+Shift+R".action = switch-preset-window-height;
          "Mod+Ctrl+R".action  = reset-window-height;
          "Mod+F".action       = maximize-column;
          "Mod+Shift+F".action = fullscreen-window;
          "Mod+Ctrl+F".action  = expand-column-to-available-width;
          "Mod+C".action       = center-column;
          "Mod+Ctrl+C".action  = center-visible-columns;
          "Mod+Minus".action   = set-column-width "-10%";
          "Mod+Equal".action   = set-column-width "+10%";
          "Mod+Shift+Minus".action = set-window-height "-10%";
          "Mod+Shift+Equal".action = set-window-height "+10%";

          # Floating + tabbed
          "Mod+V".action       = toggle-window-floating;
          "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;
          "Mod+W".action       = toggle-column-tabbed-display;

          # Volume — your exact binds
          "XF86AudioRaiseVolume" = { action = spawn sh "-c" "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; allow-when-locked = true; };
          "XF86AudioLowerVolume" = { action = spawn sh "-c" "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; allow-when-locked = true; };
          "XF86AudioMute"        = { action = spawn sh "-c" "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"; allow-when-locked = true; };
          "XF86AudioMicMute"     = { action = spawn sh "-c" "${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; allow-when-locked = true; };

          # Media keys
          "XF86AudioPlay" = { action = spawn sh "-c" "${playerctl} play-pause"; allow-when-locked = true; };
          "XF86AudioStop" = { action = spawn sh "-c" "${playerctl} stop";       allow-when-locked = true; };
          "XF86AudioPrev" = { action = spawn sh "-c" "${playerctl} previous";   allow-when-locked = true; };
          "XF86AudioNext" = { action = spawn sh "-c" "${playerctl} next";       allow-when-locked = true; };

          # Brightness
          "XF86MonBrightnessUp"   = { action = spawn brightnessctl "--class=backlight" "set" "+5%"; allow-when-locked = true; };
          "XF86MonBrightnessDown" = { action = spawn brightnessctl "--class=backlight" "set" "5%-"; allow-when-locked = true; };
        };

        # XWayland support
        xwayland.enable = true;
      };
    };
  };
}
