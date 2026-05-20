{
  flake.nixosModules.brave = {pkgs, ...}: {
    environment.systemPackages = [(pkgs.brave.override {
      commandLineArgs = ["--enable-features=UseOzonePlatform,WaylandWindowDecorations" "--ozone-platform=wayland" "--password-store=basic"];
    })];
  };
}
