# Niri compositor — Ashen Keep
# Config deployed as raw KDL via hjem to ~/.config/niri/config.kdl
# programs.niri.enable just installs the binary + wayland session
{self, ...}: {
  flake.nixosModules.niri = {pkgs, lib, config, ...}: let
    user      = config.preferences.user.name;
    wallpaper = self.wallpaper;
    sh        = lib.getExe pkgs.bash;
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
          default-column-width {
              proportion 0.5
          }
          focus-ring {
              width 2
              active-color "#c49a30ff"
              inactive-color "#2c3040aa"
          }
          border {
              off
          }
      }

      spawn-at-startup "quickshell"
      spawn-at-startup "swaybg" "-i" "${wallpaper}" "-m" "fill"
      spawn-at-startup "xwayland-satellite"
      spawn-at-startup "dunst"

      workspace "I"
      workspace "II"
      workspace "III"
      workspace "IV"
      workspace "V"

      window-rule {
          match app-id="kitty"
          draw-border-with-background false
      }
      window-rule {
          match title="nmtui"
          open-floating true
      }
      window-rule {
          match app-id="blueman-manager"
          open-floating true
      }
      window-rule {
          match app-id="pavucontrol"
          open-floating true
      }

      binds {
          Mod+Return { spawn "kitty"; }
          Mod+D      { spawn "rofi" "-show" "drun" "-show-icons"; }
          Mod+O      { toggle-overview; }
          Mod+Q      { close-window; }
          Mod+Shift+E { quit; }
          Ctrl+Alt+Delete { quit; }
          Mod+Shift+P { power-off-monitors; }
          Alt+F4 { spawn "wlogout" "-b" "2"; }

          Print         { screenshot; }
          Ctrl+Print    { screenshot-screen; }
          Alt+Print     { screenshot-window; }
          Mod+Shift+S   { spawn "${sh}" "-c" "${grim} -g \"$(${slurp} -w 0)\" - | ${wlcopy}"; }
          Mod+Ctrl+S    { spawn "${sh}" "-c" "${grim} -l 0 - | ${wlcopy}"; }

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

          Mod+Shift+Page_Down { move-workspace-down; }
          Mod+Shift+Page_Up   { move-workspace-up; }
          Mod+Shift+U         { move-workspace-down; }
          Mod+Shift+I         { move-workspace-up; }

          Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
          Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
          Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
          Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }
          Mod+WheelScrollRight     { focus-column-right; }
          Mod+WheelScrollLeft      { focus-column-left; }
          Mod+Ctrl+WheelScrollRight { move-column-right; }
          Mod+Ctrl+WheelScrollLeft  { move-column-left; }

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
          Mod+Ctrl+R  { reset-window-height; }
          Mod+F       { maximize-column; }
          Mod+Shift+F { fullscreen-window; }
          Mod+Ctrl+F  { expand-column-to-available-width; }
          Mod+C       { center-column; }
          Mod+Ctrl+C  { center-visible-columns; }
          Mod+Minus        { set-column-width "-10%"; }
          Mod+Equal        { set-column-width "+10%"; }
          Mod+Shift+Minus  { set-window-height "-10%"; }
          Mod+Shift+Equal  { set-window-height "+10%"; }

          Mod+V       { toggle-window-floating; }
          Mod+Shift+V { switch-focus-between-floating-and-tiling; }
          Mod+W       { toggle-column-tabbed-display; }

          XF86AudioRaiseVolume allow-when-locked=true { spawn "${sh}" "-c" "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.1+ -l 1.0"; }
          XF86AudioLowerVolume allow-when-locked=true { spawn "${sh}" "-c" "${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 0.1-"; }
          XF86AudioMute        allow-when-locked=true { spawn "${sh}" "-c" "${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
          XF86AudioMicMute     allow-when-locked=true { spawn "${sh}" "-c" "${wpctl} set-mute @DEFAULT_AUDIO_SOURCE@ toggle"; }

          XF86AudioPlay allow-when-locked=true { spawn "${sh}" "-c" "${pctl} play-pause"; }
          XF86AudioStop allow-when-locked=true { spawn "${sh}" "-c" "${pctl} stop"; }
          XF86AudioPrev allow-when-locked=true { spawn "${sh}" "-c" "${pctl} previous"; }
          XF86AudioNext allow-when-locked=true { spawn "${sh}" "-c" "${pctl} next"; }

          XF86MonBrightnessUp   allow-when-locked=true { spawn "${bctl}" "--class=backlight" "set" "+5%"; }
          XF86MonBrightnessDown allow-when-locked=true { spawn "${bctl}" "--class=backlight" "set" "5%-"; }
      }
    '';
  in {
    programs.niri.enable = true;
    hjem.users.${user}.files.".config/niri/config.kdl".source = niriConfig;
  };
}
