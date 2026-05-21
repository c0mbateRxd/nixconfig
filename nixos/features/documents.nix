{
  flake.nixosModules.documents = {pkgs, ...}: {
    programs.thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    environment.systemPackages = with pkgs; [
      zathura yazi unar poppler-utils ffmpegthumbnailer
      imv mpv
      libreoffice-fresh
      unzip zip p7zip unrar
      neovim
    ];
    xdg.mime.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "image/png"       = "imv.desktop";
      "image/jpeg"      = "imv.desktop";
      "video/mp4"       = "mpv.desktop";
      "inode/directory" = "thunar.desktop";
    };
  };
}
