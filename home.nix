{ config, pkgs, ... }:

let
  homeDirectory = "/Users/yetso";
  dotfiles = "${homeDirectory}/dotfiles";
in {
  xdg.enable = true;
  home = {
    username = "yetso";
    homeDirectory = "${homeDirectory}";
    stateVersion = "24.11";
    file = {
      ".config/aerospace/aerospace.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/aerospace/aerospace.toml";
      ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/fastfetch";
      ".config/nushell".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nushell";
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/nvim";
      ".ssh/config".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/ssh/config";
      ".config/starship.toml".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/starship/starship.toml";
      ".config/lazygit".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/lazygit";
      # ".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/wezterm/.config";
      # ".wezterm-completion.sh".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/wezterm/.wezterm-completion.sh";
      # ".terminfo".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/wezterm/.terminfo";
      ".config/ghostty/".source = config.lib.file.mkOutOfStoreSymlink "${dotfiles}/ghostty/";
    };
    sessionVariables = {
      HOMEBREW_NO_ANALYTICS = "1";
      HOMEBREW_NO_ENV_HINTS = "true";
      HOMEBREW_NO_AUTO_UPDATE = "1";
      HOMEBREW_FORCE_BREWED_CURL = "1";
      XDG_CONFIG_HOME = "${homeDirectory}/.config";
      _ZO_RESOLVE_SYMLINKS = "1";
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    # autosuggestion.stategy = [        # not available yet
    #   "completion"
    # ];
    # syntaxHighlighting.enable = true;     #activated with flake.nix on a system level
    enableCompletion = false;   # disabled because already there for system shell
    loginExtra = "fastfetch";
    initExtra = "bindkey '^[[H' beginning-of-line\nbindkey '^[[F' end-of-line\nbindkey '^[[3~' delete-char";
    shellAliases = {
      cat = "bat";
      lt = "ls --long --tree --level=3 --ignore-glob='.git'";
      fastfetch = "clear;command fastfetch";
      lg = "lazygit";
      v = "nvim";
      docker = "podman";
      update = "\
        open /Applications/Latest.app
        brew update --quiet
        brew upgrade --quiet
        echo -e '\\e[34m==>\\e[0m \\e[1mupdating flake lock...\\e[0m'
        (cd ~/dotfiles && nix flake update --commit-lock-file > /dev/null)
        echo -e '\\e[34m==>\\e[0m \\e[1m rebuilding nix-darwin...\\e[0m'
        darwin-rebuild switch --flake ~/dotfiles > /dev/null
      ";
    };
  };


  programs.starship = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = true;
    enableIonIntegration = false;
    enableNushellIntegration = false;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = true;
    enableNushellIntegration = false;
    options = ["--cmd cd"];
  };

  programs.lazygit = { enable = true; };

  programs.fastfetch.enable = true;

  programs.eza = {
    enable = true;
    icons = "always";
    extraOptions = [
      "--binary"
      "--group-directories-first"
      "--header"
      "--no-quotes"
      "--all"
      "--color=always"
      "--ignore-glob=.DS_Store"
    ];
  };

  programs.bat = {
    enable = true;
    config.theme = "fly16";
    themes = {
      fly16 = {
        src = pkgs.fetchFromGitHub {
          owner = "bluz71";
          repo = "fly16-bat"; # Bat uses sublime syntax for its themes
          rev = "d13c2c2a03e84819b2df2c50bc824b74604b9844";
          hash = "sha256-QtZurXK6wNnyWiiQWfyAMFsV5ZWyi84jJNkTgZYoMCE=";
        };
        file = "fly16.tmTheme";
      };
    };
  };

  # home.packages = [
  
  # ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


  programs.git = {
    enable = true;
    userName = "Yetso";
    userEmail = "dav.catoul@gmail.com";
  };

  programs.yazi = {
    enable = true;
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = true;
    enableNushellIntegration = false;
  };
}
