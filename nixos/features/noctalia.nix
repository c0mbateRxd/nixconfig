# Noctalia shell — minimal Wayland desktop shell with native Niri support.
# Uses its own Quickshell fork (noctalia-qs) — no module compilation issues.
# Required services (bluetooth, upower, blueman) already in desktop.nix.
{inputs, ...}: {
  flake.nixosModules.noctalia = {pkgs, ...}: {
    environment.systemPackages = [
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
