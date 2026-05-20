# Ashen Keep — Dark Souls / gothic steampunk base16 palette
# Cool blue-black base, desaturated fog tones, amber bonfire highlights.
# Pulled from: ruined castles, fog-covered peaks, divine light through storm clouds.
let
  theme = {
    base00 = "#0a0b0e"; # Abyss          — deepest terminal/panel bg
    base01 = "#12141a"; # Cinder          — darker ui surfaces
    base02 = "#1c1f28"; # Dark Ash        — selection background
    base03 = "#2c3040"; # Grave Iron      — comments, inactive text
    base04 = "#6a7088"; # Faded Rune      — dim ui text
    base05 = "#b0b8c8"; # Pale Ash        — default text
    base06 = "#c8d0e0"; # Moonstone       — bright text
    base07 = "#e0e6f0"; # Phantom White   — lightest (titles, headers)
    base08 = "#a83a3a"; # Blood Ember     — red / errors
    base09 = "#c49a30"; # Bonfire Gold    — orange / HERO accent
    base0A = "#d4b44e"; # Soul Ember      — yellow / warnings
    base0B = "#5a8a58"; # Moss on Ruins   — green / success
    base0C = "#4a7e96"; # Frigid Steel    — cyan / info
    base0D = "#6070a8"; # Lothric Blue    — blue / links
    base0E = "#7a5090"; # Phantom Violet  — magenta / special
    base0F = "#705838"; # Rusted Bronze   — brown / deprecated
  };

  stripHash = str:
    if builtins.substring 0 1 str == "#"
    then builtins.substring 1 (builtins.stringLength str - 1) str
    else str;

  themeNoHash = builtins.mapAttrs (_: v: stripHash v) theme;
in {
  flake = {
    inherit theme themeNoHash;
  };
}
