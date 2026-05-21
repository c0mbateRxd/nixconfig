# Waybar — Ashen Keep themed top bar.
# Config + CSS deployed via hjem to ~/.config/waybar/
{...}: {
  flake.nixosModules.waybar = {pkgs, config, ...}: let
    user = config.preferences.user.name;
  in {
    environment.systemPackages = [pkgs.waybar];
    hjem.users.${user}.files = {
      ".config/waybar/config.jsonc".source = ./waybar/config.jsonc;
      ".config/waybar/style.css".source    = ./waybar/style.css;
    };
  };
}
