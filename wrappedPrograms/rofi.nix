# Rofi launcher — Ashen Keep theme.
# Config deployed via system.userActivationScripts to ensure it lands correctly.
{...}: {
  flake.nixosModules.rofi = {pkgs, config, lib, ...}: let
    user       = config.preferences.user.name;
    configRasi = ./rofi/config.rasi;
  in {
    environment.systemPackages = [pkgs.rofi-wayland];
    
    # Deploy config on every activation — bypasses hjem reliability issues
    system.userActivationScripts.rofiConfig = {
      text = ''
        mkdir -p "$HOME/.config/rofi"
        cp --no-preserve=all ${configRasi} "$HOME/.config/rofi/config.rasi"
        chmod 644 "$HOME/.config/rofi/config.rasi"
      '';
    };
  };
}
