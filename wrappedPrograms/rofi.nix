# Rofi launcher — rofi + Ashen Keep theme deployed via hjem.
{
  flake.nixosModules.rofi = {pkgs, config, ...}: let
    user = config.preferences.user.name;
  in {
    environment.systemPackages = [pkgs.rofi];
    hjem.users.${user}.files.".config/rofi/config.rasi".source = ./rofi/config.rasi;
  };
}
