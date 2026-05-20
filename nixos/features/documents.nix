{
  flake.nixosModules.documents = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      zathura yazi unar poppler ffmpegthumbnailer
      imv mpv
      thunar thunar-archive-plugin thunar-volman
      libreoffice-fresh
      unzip zip p7zip unrar
    ];
    xdg.mime.defaultApplications = {
      "application/pdf" = "org.pwmt.zathura.desktop";
      "image/png" = "imv.desktop"; "image/jpeg" = "imv.desktop";
      "video/mp4" = "mpv.desktop"; "text/plain" = "nvim.desktop";
      "inode/directory" = "thunar.desktop";
    };
  };
}
