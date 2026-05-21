# Cider — Apple Music client. Marked broken in nixpkgs; we override
# just this package rather than allowBroken globally (faster eval).
{
  flake.nixosModules.cider = {pkgs, ...}: {
    environment.systemPackages = [
      (pkgs.cider.overrideAttrs (_: { meta.broken = false; }))
    ];
  };
}
