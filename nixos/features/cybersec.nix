{
  flake.nixosModules.cybersec = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nmap netcat-gnu tcpdump inetutils curl wget
      binwalk rizin file unixtools.xxd
      hashcat openssl
      python3 python3Packages.requests python3Packages.pycryptodome
      exiftool foremost binutils
    ];
  };
}
