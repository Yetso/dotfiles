{
  description = "Yetso Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = { self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
    let
      configuration = { pkgs, config, lib, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nix.settings.trusted-users = [
          "root"
          "@admin"
        ];
        environment.systemPackages = with pkgs; [
          aerospace
          cargo
          delta
          # duti
          fd
          fzf
          gh
          git
          go
          gradle
          lua
          neovim
          # nushell
          podman
          python312
          python312Packages.pip
          ripgrep
          # typst
          wget
          zoxide
          zulu
        ];

        environment.systemPath = [
          "/Applications/Ghostty.app/Contents/MacOS/"
        ];

        environment.variables = {
          EDITOR = "nvim";
          LANG = "en_US.UTF-8";
          HOMEBREW_NO_ANALYTICS = "1";
          HOMEBREW_NO_ENV_HINTS = "1";
          XDG_CONFIG_HOME = "/Users/yetso/.config";
          _ZO_RESOLVE_SYMLINKS = "1";
        };
        environment.shells = [ pkgs.zsh ];

        fonts.packages = with pkgs; [
          nerd-fonts.commit-mono
        ];

        homebrew = {
          enable = true;
          onActivation.cleanup = "zap";
          onActivation.autoUpdate = true;
          onActivation.upgrade = true;
          brews = [ "curl" ];
          casks = [
            "appcleaner"
            "bitwarden"
            "brave-browser"
            "cyberghost-vpn"
            # "firefox"
            "floorp"
            # "foxitreader"
            "ghostty"
            "latest"
            "onlyoffice"
            "qbittorrent"
            "skim"
            "spotify"
            "unnaturalscrollwheels"
            {
              name = "yetso/vesktop/vesktop";
              greedy = true;
            }
            "vlc"
            # { name = "wezterm@nightly"; }
          ];
          taps = ["yetso/vesktop"];
        };

        users.users.yetso.home = "/Users/yetso";


        system.defaults = {
          ".GlobalPreferences"."com.apple.mouse.scaling" = 0.875;
          hitoolbox.AppleFnUsageType = "Do Nothing";
          LaunchServices.LSQuarantine = false;
          NSGlobalDomain = {
            AppleEnableSwipeNavigateWithScrolls = true;
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
            NSTableViewDefaultSizeMode = 1;
            NSWindowResizeTime = 0.0;
            "com.apple.keyboard.fnState" = true;
            "com.apple.sound.beep.feedback" = 1;
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
            magnification = false;
            mineffect = "scale";
            minimize-to-application = true;
            persistent-apps = [
              # "/Applications/Firefox.app"
              "/Applications/Floorp.app"
              "/System/Applications/Mail.app"
              "/Applications/Ghostty.app"
              "/System/Applications/Music.app"
              "/Applications/Vesktop.app"
            ];
            show-recents = false;
            tilesize = 48;
            wvous-bl-corner = 11; #add launchpad shortcut on hotCorner
          };
          finder = {
            AppleShowAllExtensions = true;
            FXDefaultSearchScope = "SCcf";
            FXPreferredViewStyle = "Nlsv";
            _FXSortFoldersFirst = true;
            ShowPathbar = true;
          };
          trackpad.ActuationStrength = 1;
          trackpad.TrackpadRightClick = true;
          universalaccess.mouseDriverCursorSize = 0.5;
        };
        time.timeZone = "Europe/Brussels";
        system.startup.chime = false;

        security.pam.services.sudo_local.touchIdAuth = true;

        # Auto upgrade nix package and the daemon service.
        nix.package = pkgs.nix;

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.bash.enable = false;
        programs.zsh = {
          enable = true;
          enableSyntaxHighlighting = true;
          enableBashCompletion = false;
          promptInit = "autoload -Uz promptinit && promptinit";
        };
        programs.fish.enable = false;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;
        nixpkgs.hostPlatform = "aarch64-darwin";

        nixpkgs.config.allowUnfree = true; # allow non open source application

        system.stateVersion = 5;
        # nix.extraOptions = ''
        #   extra-platforms = x86_64-darwin aarch64-darwin
        # '';

        # Just to add JDK
        system.activationScripts.extraActivation.text = "ln -sf '${pkgs.zulu}/zulu-21.jdk' '/Library/Java/JavaVirtualMachines/'";
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Yetso-laptop
      darwinConfigurations."yetsos-MacBook-Pro" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.yetso = import ./home.nix;
          }
          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              # Apple Silicon Only: Also install Homebrew under the default Intel prefix for Rosetta 2
              # enableRosetta = true;
              # User owning the Homebrew prefix
              user = "yetso";
              # Automatically migrate existing Homebrew installations
              # autoMigrate = true;
            };
          }
        ];
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."yetsos-MacBook-Pro".pkgs;
    };
}
