# Kitty terminal — Ashen Keep palette, deployed via hjem
{...}: {
  flake.nixosModules.kitty = {pkgs, config, ...}: let
    user = config.preferences.user.name;
    kittyConf = pkgs.writeText "kitty.conf" ''
      # Font
      font_family      JetBrainsMono Nerd Font
      font_size        13.0

      # JELLY CURSOR TRAIL
      cursor_trail                 3
      cursor_trail_decay           0.05 0.4
      cursor_trail_start_threshold 2
      shell_integration            no-cursor
      cursor_shape                 beam
      cursor_blink_interval        0.5
      cursor_stop_blinking_after   15.0
      cursor_beam_thickness        2.0

      # Ashen Keep palette
      background           #0a0b0e
      foreground           #b0b8c8
      cursor               #c49a30
      cursor_text_color    #0a0b0e
      selection_background #1c1f28
      selection_foreground #c8d0e0

      active_tab_foreground   #c49a30
      active_tab_background   #1c1f28
      inactive_tab_foreground #6a7088
      inactive_tab_background #12141a

      color0  #0a0b0e
      color1  #a83a3a
      color2  #5a8a58
      color3  #d4b44e
      color4  #6070a8
      color5  #7a5090
      color6  #4a7e96
      color7  #c8d0e0
      color8  #2c3040
      color9  #a83a3a
      color10 #5a8a58
      color11 #d4b44e
      color12 #6070a8
      color13 #7a5090
      color14 #4a7e96
      color15 #e0e6f0

      # Window
      window_padding_width    8
      hide_window_decorations yes
      background_opacity      0.93

      # Misc
      confirm_on_close     never
      enable_audio_bell    no
      tab_bar_style        powerline
      allow_remote_control yes

      # Keybinds
      map alt+1         goto_tab 1
      map alt+2         goto_tab 2
      map alt+3         goto_tab 3
      map alt+4         goto_tab 4
      map alt+5         goto_tab 5
      map ctrl+shift+w  close_tab
      map ctrl+t        new_tab_with_cwd
      map ctrl+shift+t  new_tab
    '';
  in {
    environment.systemPackages = [pkgs.kitty];
    hjem.users.${user}.files.".config/kitty/kitty.conf".source = kittyConf;
  };
}
