{self, ...}: {
  flake.nixosModules.bash = {pkgs, lib, config, ...}: let
    starshipConfig = pkgs.writeText "starship.toml" ''
      add_newline = false
      palette = "ashen"

      [palettes.ashen]
      gold   = "#c49a30"
      moss   = "#5a8a58"
      ember  = "#a83a3a"
      frost  = "#4a7e96"
      ink    = "#6a7088"
      ash    = "#b0b8c8"
      violet = "#6070a8"

      [character]
      success_symbol = "[❯](bold gold)"
      error_symbol   = "[❯](bold ember)"

      [directory]
      style             = "bold frost"
      truncation_length = 3
      truncate_to_repo  = true
      format            = "[$path]($style)[$read_only]($read_only_style) "

      [git_branch]
      style  = "bold violet"
      symbol = " "

      [git_status]
      style = "bold gold"

      [cmd_duration]
      style    = "bold moss"
      min_time = 2000
      format   = "took [$duration]($style) "

      [username]
      style_user  = "bold ember"
      show_always = false
    '';
  in {
    programs.bash = {
      enable = true;
      completion.enable = true;
      interactiveShellInit = ''
        # Completion (your exact settings)
        bind "set show-all-if-ambiguous on"
        bind 'TAB: menu-complete'
        bind '"\e[Z": menu-complete-backward'
        bind "set completion-ignore-case on"
        bind "set colored-stats on"
        bind "set mark-symlinked-directories on"

        # History
        HISTSIZE=10000
        HISTFILESIZE=20000
        HISTCONTROL=ignoreboth:erasedups
        shopt -s histappend checkwinsize

        eval "$(${lib.getExe pkgs.starship} init bash --print-full-init)"
        eval "$(${lib.getExe pkgs.zoxide} init bash)"
        source ${pkgs.fzf}/share/fzf/key-bindings.bash
        source ${pkgs.fzf}/share/fzf/completion.bash
      '';
      shellAliases = {
        # System
        rebuild = "nh os switch";
        check   = "nix flake check ~/nixconfig";
        clean   = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
        update  = "nix flake update ~/nixconfig";
        diff    = "nvd diff $(ls -d /nix/var/nix/profiles/system-*-link | tail -2)";
        # Git
        gs = "git status"; ga = "git add"; gc = "git commit"; gp = "git push";
        gl = "git log --oneline --graph --decorate --all";
        # Better defaults
        ls   = "${lib.getExe pkgs.eza} --icons --group-directories-first";
        ll   = "${lib.getExe pkgs.eza} --icons --group-directories-first -la";
        lt   = "${lib.getExe pkgs.eza} --icons --tree --level=2";
        cat  = "${lib.getExe pkgs.bat} --style=plain";
        grep = "${lib.getExe pkgs.ripgrep}";
        find = "${lib.getExe pkgs.fd}";
        top  = "${lib.getExe pkgs.btop}";
        # CTF helpers
        b64d    = "base64 --decode";
        b64e    = "base64 --encode";
        hex     = "xxd";
        strings = "strings -a";
      };
    };
    environment.sessionVariables = {
      STARSHIP_CONFIG = toString starshipConfig;
      EDITOR = "nvim"; VISUAL = "nvim";
    };
    environment.systemPackages = with pkgs; [
      starship zoxide fzf bat eza ripgrep fd btop dust tldr
      lazygit fastfetch yt-dlp ffmpeg-full imagemagick
      tree file unzip zip p7zip wget killall tmux git
    ];
  };
}
