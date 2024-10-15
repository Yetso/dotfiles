{
  description = "Yetso Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = { self, nix-darwin, nixpkgs, nix-homebrew }:
    let
      configuration = { pkgs, config, lib, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          pkgs.bat
          pkgs.cargo
          pkgs.duti
          pkgs.eza
          pkgs.fastfetch
          pkgs.fzf
          pkgs.git
          pkgs.gradle
          pkgs.lazygit
          pkgs.lua
          pkgs.neovim
          pkgs.python3
          pkgs.starship
          pkgs.stow
          pkgs.wget
          pkgs.zoxide
          pkgs.zulu
        ];
        environment.variables = {
          EDITOR = "nvim";
          LANG = "en_US.UTF-8";
        };

        fonts.packages = with pkgs; [
          (nerdfonts.override { fonts = [ "CommitMono" ]; })
        ];

        homebrew = {
          enable = true;
          casks = [
            "appcleaner"
            "bitwarden"
            "brave-browser"
            "bruno"
            "coteditor"
            "cyberghost-vpn"
            "discord"
            "firefox"
            "foxitreader"
            "latest"
            { name = "logi-options+"; }
            "onlyoffice"
            "qbittorrent"
            "unnaturalscrollwheels"
            "vlc"
            { name = "wezterm@nightly"; }
          ];
          onActivation.cleanup = "zap";
        };

        system.defaults = {
          ".GlobalPreferences"."com.apple.mouse.scaling" = 0.6875;
          LaunchServices.LSQuarantine = false;
          NSGlobalDomain = {
            AppleInterfaceStyle = "Dark";
            AppleMeasurementUnits = "Centimeters";
            AppleMetricUnits = 1;
            AppleShowAllExtensions = true;
            AppleTemperatureUnit = "Celsius";
            InitialKeyRepeat = 15;
            KeyRepeat = 2;
            NSAutomaticCapitalizationEnabled = false;
            NSDisableAutomaticTermination = false;
            NSScrollAnimationEnabled = false;
            NSWindowResizeTime = 0.0;
            "com.apple.keyboard.fnState" = true;
            "com.apple.springing.enabled" = false;
            "com.apple.trackpad.forceClick" = false;
          };
          WindowManager.AppWindowGroupingBehavior = true;
          WindowManager.EnableStandardClickToShowDesktop = false;
          WindowManager.StandardHideDesktopIcons = false;
          dock = {
            autohide = true;
            autohide-delay = 0.0;
            autohide-time-modifier = 0.1;
            expose-animation-duration = 0.3;
            magnification = true;
            mineffect = "scale";
            minimize-to-application = true;
            persistent-apps = [
              "/Applications/Firefox.app"
              "/System/Applications/Mail.app"
              "/Applications/WezTerm.app"
              "/System/Applications/Music.app"
            ];
            show-recents = false;
            tilesize = 48;
            wvous-bl-corner = 11;
          };
          finder.AppleShowAllExtensions = true;
          finder.FXDefaultSearchScope = "SCcf";
          finder.FXPreferredViewStyle = "Nlsv";
          finder.ShowPathbar = true;
        };
        system.startup.chime = false;

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.bash.enable = false;
        programs.zsh.enable = false;
        programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
        nixpkgs.hostPlatform = "aarch64-darwin";

        # nixpkgs.config.allowUnfree = true; # allow non open source application

        system.stateVersion = 5;

        # Just to add JDK
        system.activationScripts.extraActivation.text = "ln -sf '${pkgs.zulu}/zulu-21.jdk' '/Library/Java/JavaVirtualMachines/'";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Yetso-laptop
      darwinConfigurations."Yetso-laptop" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              # Install Homebrew under the default prefix
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              enableRosetta = true;
              # User owning the Homebrew prefix
              user = "yetso";
              # Automatically migrate existing Homebrew installations
              # autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."Yetso-laptop".pkgs;
    };
}
