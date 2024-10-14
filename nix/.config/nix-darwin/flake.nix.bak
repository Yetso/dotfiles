{
  description = "Yetso Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
    let
      configuration = { pkgs, config, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          # pkgs.neovim
          # pkgs.git
          # pkgs.bat
          # pkgs.eza
          # pkgs.fastfetch
          # pkgs.lazygit
          # pkgs.starship
          # pkgs.wget
          # pkgs.cargo
          # pkgs.stow
          # pkgs.zoxide
          # pkgs.zsh
          # pkgs.zsh-autosuggestions
          # pkgs.gradle
          # pkgs.fzf
          # pkgs.git
          # pkgs.lua
          # pkgs.duti
        ];

        # fonts.packages = with pkgs; [
        #   (nerdfonts.override { fonts = [ "CommitMono" ]; })
        # ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs.config.allowUnfree = true;
        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh = {
          enable = true;
          # enableSyntaxHighlighting = true;
          # promptInit = ''
          #   source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
          # '';
          # shellInit = ''
          #   fastfetch
          # '';
# 			if [[ "$TERM" == "wezterm" ]]; then
# 			source ~/.wezterm-completion.sh
# 		      fi	
# if command -v starship &>/dev/null; then
#         eval "$(starship init zsh)" >/dev/null
#       fi
#       if command -v zoxide &>/dev/null; then
#         eval "$(zoxide init zsh --cmd cd)"
#       fi
        };

        users.users."Davids-MacBook-Pro".shell = pkgs.zsh;
        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 5;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
        # nix.extraOptions = ''
        #   extra-platforms = x86_64-darwin aarch64-darwin
        # '';

        environment.shells = [
          pkgs.zsh
        ];

        # environment.shellAliases = {
        #   cat = "bat --paging=never --theme='fly16'";
        #   ls = "eza --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes";
        #   lt = "eza --long --tree --level=3 --all --header --binary --color=always --group-directories-first --icons=always --ignore-glob='.DS_Store' --no-quotes";
        #   fastfetch "clear;fastfetch";
        #   v = "nvim";
        #   update = "";
        # };
        # environment.variables = {
        #   XDG_CONFIG_HOME = "${config.home.homeDirectory}/.config";
        #   EDITOR = "${pkgs.neovim}/bin/nvim";
        #   HOMEBREW_NO_ENV_HINTS = "true";
        #   STARSHIP_CONFIG = "${config.home.homeDirectory}/.config/starship/starship.toml";
        # };

        homebrew.enable = true;
        homebrew.brews = [
          "neovim"
          "git"
          "bat"
          "eza"
          "fastfetch"
          "lazygit"
          "wget"
          "stow"
          "zoxide"
          "zsh"
          "zsh-autosuggestions"
          "zsh-syntax-highlighting"
          "starship"
          "gradle"
          "fzf"
          "lua"
          "duti"
        ];

        homebrew.casks = [
          "appcleaner"
          "discord"
          "firefox"
          "wezterm@nightly"
        ];

        security.pam.enableSudoTouchIdAuth = true;

        system.defaults = {
          dock.autohide = true;
          finder.AppleShowAllExtensions = true;
          finder.FXPreferredViewStyle = "Nlsv";
          screensaver.askForPasswordDelay = 60;
          finder.ShowPathbar = true;
          finder._FXSortFoldersFirst = true;
          finder.FXDefaultSearchScope = "SCcf";
          trackpad.FirstClickThreshold = 1;
          trackpad.SecondClickThreshold = 2;
          trackpad.TrackpadRightClick = true;
          dock.show-recents = false;
        };
        system.startup.chime = false;
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .
      darwinConfigurations."Yetso" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Yetso".pkgs;
    };
}
