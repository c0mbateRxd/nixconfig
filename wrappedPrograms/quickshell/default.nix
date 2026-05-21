# Quickshell panel — wraps quickshell binary with our QML config dir.
{inputs, ...}: {
  flake.nixosModules.quickshell = {pkgs, ...}: let
    qsPkg = inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default;
    configDir = ./config;
    wrapped = pkgs.writeShellScriptBin "quickshell" ''
      exec ${qsPkg}/bin/quickshell -p ${configDir}/shell.qml "$@"
    '';
  in {
    environment.systemPackages = [wrapped qsPkg];
  };
}
