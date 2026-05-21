# Niri compositor — Ashen Keep. Config deployed as raw KDL via hjem.
# CRITICAL: all spawned programs use absolute store paths — niri does
# not reliably resolve bare binary names from PATH.
{self, ...}: {
  flake.nixosModules.niri = {pkgs, lib, config, ...}: let
    user      = config.preferences.user.name;
    wallpaper = self.wallpaper;

    # Absolute paths — niri spawn needs these, not bare names
    sh        = lib.getExe pkgs.bash;
    kitty     = lib.getExe pkgs.kitty;
    rofi      = lib.getExe pkgs.rofi;
    swaybg    = lib.getExe pkgs.swaybg;
    dunst     = lib.getExe pkgs.dunst;
    wlogout   = lib.getExe pkgs.wlogout;
    xwlsat    = lib.getExe pkgs.xwayland-satellite;
    wpctl     = "${pkgs.wireplumber}/bin/wpctl";
    bctl      = lib.getExe pkgs.brightnessctl;
    pctl      = lib.getExe pkgs.playerctl;
    grim      = lib.getExe pkgs.grim;
    slurp     = lib.getExe pkgs.slurp;
    wlcopy    = "${pkgs.wl-clipboard}/bin/wl-copy";

    niriConfig = pkgs.writeText "config.kdl" ''
      prefer-no-csd

      input {
          keyboard {
              xkb {
                  layout "us"
              }
              repeat-delay 300
              repeat-rate 35
              numlock
          }
          touchpad {
              tap
              natural-scroll
              dwt
          }
          focus-follows-mouse max-scroll-amount="0%"
      }

      layout {
          gaps 8
          center-focused-column "never"
          preset-column-widths {
              proportion 0.33333
              proportion 0.5
              proportion 0.66667
          }
          default-column-width { proportion 0.5; }
          focus-ring {
              width 2
              active-color "#c49a30ff"
              inactive-color "#2c3040aa"
          }
      }

      spawn-at-startup "${swaybg}" "-i" "${wallpaper}" "-m" "fill"
      spawn-at-startup "/run/current-system/sw/bin/waybar"
      spawn-at-startup "${xwlsat}"
      spawn-at-startup "${dunst}"

      environment {
          DISPLAY ":0"
      }

      workspace "I"
      workspace "II"
      workspace "III"
      workspace "IV"
      workspace "V"

      hotkey-overlay {
          skip-at-startup
      }

      window-rule {
          match app-id="kitty"
          draw-border-with-background false
      }
      window-rule {
          geometry-corner-radius 8
          clip-to-geometry true
      }

      binds {
          Mod+Return { spawn "${kitty}"; }
          Mod+D      { spawn "${rofi}" "-show" "drun"; }
          Mod+Q      { close-window; }
          Mod+Shift+E { quit; }
          Mod+Shift+P { power-off-monitors; }
          Alt+F4 { spawn "${wlogout}" "-b" "2"; }

          Print         { screenshot; }
          Ctrl+Print    { screenshot-screen; }
          Alt+Print     { screenshot-window; }
          Mod+Shift+S   { spawn "${sh}" "-c" "${grim} -g \"$(${slurp})\" - | ${wlcopy}"; }
          Mod+Ctrl+S    { spawn "${sh}" "-c" "${grim} - | ${wlcopy}"; }

          Mod+Left  { focus-column-left; }
          Mod+Down  { focus-window-down; }
          Mod+Up    { focus-window-up; }
          Mod+Right { focus-column-right; }
          Mod+H     { focus-column-left; }
          Mod+J     { focus-window-down; }
          Mod+K     { focus-window-up; }
          Mod+L     { focus-column-right; }

          Mod+Ctrl+Left  { move-column-left; }
          Mod+Ctrl+Down  { move-window-down; }
          Mod+Ctrl+Up    { move-window-up; }
          Mod+Ctrl+Right { move-column-right; }
          Mod+Ctrl+H     { move-column-left; }
          Mod+Ctrl+J     { move-window-down; }
          Mod+Ctrl+K     { move-window-up; }
          Mod+Ctrl+L     { move-column-right; }

          Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
          Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

          Mod+1 { focus-workspace "I"; }
          Mod+2 { focus-workspace "II"; }
          Mod+3 { focus-workspace "III"; }
          Mod+4 { focus-workspace "IV"; }
          Mod+5 { focus-workspace "V"; }
          Mod+Shift+1 { move-column-to-workspace "I"; }
          Mod+Shift+2 { move-column-to-workspace "II"; }
          Mod+Shift+3 { move-column-to-workspace "III"; }
          Mod+Shift+4 { move-column-to-workspace "IV"; }
          Mod+Shift+5 { move-column-to-workspace "V"; }

          Mod+BracketLeft  { consume-or-expel-window-left; }
          Mod+BracketRight { consume-or-expel-window-right; }
          Mod+Period       { expel-window-from-column; }

          Mod+R       { switch-preset-column-width; }
          Mod+Shift+R { switch-preset-window-height; }
          Mod+F       { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+C       { center-column; }
          Mod+Minus        { set-column-width "-10%"; }
          Mod+Equal        { set-column-width "+10%"; }

          Mod+V       { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }
          Mod+W       { toggle-column-tabbed-display; }
          Mod+O       { toggle-overview; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+" "-l" "1.0"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "${wpctl}" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-"; }
          XF86AudioMute        allow-when-locked=true { spawn "${wpctl}" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
          XF86AudioMicMute     allow-when-locked=true { spawn "${wpctl}" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

          XF86AudioPlay allow-when-locked=true { spawn "${pctl}" "play-pause"; }
          XF86AudioPrev allow-when-locked=true { spawn "${pctl}" "previous"; }
          XF86AudioNext allow-when-locked=true { spawn "${pctl}" "next"; }

          XF86MonBrightnessUp   allow-when-locked=true { spawn "${bctl}" "set" "+5%"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "${bctl}" "set" "5%-"; }
      }
    '';
  in {
    programs.niri.enable = true;
    hjem.users.${user}.files.".config/niri/config.kdl".source = niriConfig;
  };
}
