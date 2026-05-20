# Rofi launcher — installs rofi-wayland and deploys Ashen Keep theme.
# Theme file lands at ~/.config/rofi/config.rasi via hjem.
# Keybind Super+D → rofi is in wrappedPrograms/niri.nix.
{
  flake.nixosModules.rofi = {
    pkgs,
    config,
    ...
  }: let
    user = config.preferences.user.name; # "nyght"
  in {
    environment.systemPackages = [pkgs.rofi-wayland];

    # Deploy the themed rasi file via hjem (our dotfile manager)
    hjem.users.${user}.files = {
      ".config/rofi/config.rasi".source = ./rofi/config.rasi;
    };
  };
}
