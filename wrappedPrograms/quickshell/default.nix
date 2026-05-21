# Quickshell panel — wraps quickshell with our QML config dir
{inputs, ...}: {
  flake.nixosModules.quickshell = {pkgs, ...}: let
    qsPkg = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    configDir = ./config;
    wrapped = pkgs.writeShellScriptBin "quickshell" ''
      exec ${qsPkg}/bin/quickshell -c ${configDir} "$@"
    '';
  in {
    environment.systemPackages = [wrapped qsPkg];
  };
}
