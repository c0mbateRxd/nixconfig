# Kitty terminal — Eldritch Ash palette, deployed via hjem
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

      # Eldritch Ash palette
      background           #08090d
      foreground           #a1acc2
      cursor               #5299ad
      cursor_text_color    #08090d
      selection_background #1b202c
      selection_foreground #ccd4e6

      active_tab_foreground   #5299ad
      active_tab_background   #1b202c
      inactive_tab_foreground #566580
      inactive_tab_background #10131a

      color0  #08090d
      color1  #b83333
      color2  #4b855a
      color3  #c97b28
      color4  #5c70b0
      color5  #7e5296
      color6  #5299ad
      color7  #ccd4e6
      color8  #2a3245
      color9  #b83333
      color10 #4b855a
      color11 #d6a848
      color12 #5c70b0
      color13 #7e5296
      color14 #5299ad
      color15 #eef1f8

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
