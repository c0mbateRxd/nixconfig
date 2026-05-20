{
  flake.nixosModules.cybersec = {pkgs, ...}: {
    environment.systemPackages = with pkgs; [
      nmap netcat-gnu tcpdump inetutils curl wget
      binwalk rizin file hexdump xxd
      hashcat openssl
      steghide stegseek
      python3 python3Packages.requests python3Packages.pycryptodome
      exiftool foremost binutils
    ];
  };
}
