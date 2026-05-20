{
  flake.nixosModules.cider = {pkgs, ...}: {
    # Cider is marked broken in nixpkgs unstable — allow it
    nixpkgs.config.allowBroken = true;
    environment.systemPackages = [pkgs.cider];
  };
}
