# Eldritch Ash — Dark Souls x Lord of Mysteries x Evangelion (Rei)
# Cool abyssal blues, frosty London fog, brass clockwork, and crimson accents.
let
  theme = {
    base00 = "#08090d"; # Deepest Void   — deepest terminal/panel bg
    base01 = "#10131a"; # Cold Cinder    — darker ui surfaces
    base02 = "#1b202c"; # Steampunk Iron — selection background
    base03 = "#2a3245"; # Rusted Gear    — comments, inactive text
    base04 = "#566580"; # Foggy Slate    — dim ui text
    base05 = "#a1acc2"; # Rei's Ash      — default text
    base06 = "#ccd4e6"; # Moonlit Fog    — bright text
    base07 = "#eef1f8"; # Stark White    — lightest (titles, headers)
    base08 = "#b83333"; # Crimson Moon   — red / errors (Eva Red)
    base09 = "#c97b28"; # Brass Gold     — orange / HERO accent
    base0A = "#d6a848"; # Fading Bonfire — yellow / warnings
    base0B = "#4b855a"; # Overgrown Moss — green / success
    base0C = "#5299ad"; # Icy Ayanami    — cyan / info
    base0D = "#5c70b0"; # Abyssal Sea    — blue / links
    base0E = "#7e5296"; # Eldritch Void  — magenta / special
    base0F = "#7a593c"; # Leather & Ash  — brown / deprecated
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
