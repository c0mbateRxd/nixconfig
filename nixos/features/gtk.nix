{
  flake.nixosModules.gtk = {pkgs, lib, ...}: let
    gtkSettings = ''
      [Settings]
      gtk-theme-name = Adwaita-dark
      gtk-icon-theme-name = Papirus-Dark
      gtk-font-name = Inter 11
      gtk-application-prefer-dark-theme = true
    '';
  in {
    environment.etc = {
      "xdg/gtk-3.0/settings.ini".text = gtkSettings;
      "xdg/gtk-4.0/settings.ini".text = gtkSettings;
    };
    environment.variables.GTK_THEME = "Adwaita-dark";
    programs.dconf = {
      enable = lib.mkDefault true;
      profiles.user.databases = [{
        lockAll = false;
        settings."org/gnome/desktop/interface" = {
          gtk-theme = "Adwaita-dark"; icon-theme = "Papirus-Dark";
          color-scheme = "prefer-dark"; font-name = "Inter 11";
        };
      }];
    };
    environment.systemPackages = with pkgs; [adwaita-icon-theme papirus-icon-theme gtk3 gtk4];
  };
}
