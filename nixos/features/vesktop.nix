{
  flake.nixosModules.vesktop = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [vesktop kdePackages.xwaylandvideobridge];
  };
}
