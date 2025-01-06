{
  description = "Yetso nixos system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager }:
    let
      configuration = { pkgs, config, lib, ... }: {
        imports = [
          # Include the results of the hardware scan.
          ./hardware-configuration.nix
        ];

        ##### NIXOS config
        # Bootloader.
        boot.loader.systemd-boot.enable = true;
        boot.loader.efi.canTouchEfiVariables = true;

        networking.hostName = "nixos"; # Define your hostname.
        # Enable networking
        networking.networkmanager.enable = true;

        # Set your time zone.
        time.timeZone = "Europe/Brussels";

        # Select internationalisation properties.
        i18n.defaultLocale = "en_US.UTF-8";
        nix.gc = {
          automatic = true;
          randomizedDelaySec = "14m";
          options = "--delete-older-than 5d";
        };
        # Enable OpenGL
        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };

        # Enable the X11 windowing system.
        services.xserver.enable = true;
        services.xserver.videoDrivers = [ "nvidia" ];

        hardware.nvidia = {
          # Modesetting is required.
          modesetting.enable = true;

          prime = {
            sync.enable = true;
            amdgpuBusId = "PCI:0:0:0";
            nvidiaBusId = "PCI:8:0:0";
          };

          # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
          # Enable this if you have graphical corruption issues or application crashes after waking
          # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
          # of just the bare essentials.
          powerManagement.enable = false;

          # Fine-grained power management. Turns off GPU when not in use.
          # Experimental and only works on modern Nvidia GPUs (Turing or newer).
          powerManagement.finegrained = false;

          # Use the NVidia open source kernel module (not to be confused with the
          # independent third-party "nouveau" open source driver).
          # Support is limited to the Turing and later architectures. Full list of supported GPUs is at:
          # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
          # Only available from driver 515.43.04+
          # Currently alpha-quality/buggy, so false is currently the recommended setting.
          open = false;

          # Enable the Nvidia settings menu,
          # accessible via `nvidia-settings`.
          nvidiaSettings = true;

          # Optionally, you may need to select the appropriate driver version for your specific GPU.
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };

        # Enable the KDE Plasma Desktop Environment.
        services.displayManager.sddm.enable = true;
        services.desktopManager.plasma6.enable = true;

        # Configure keymap in X11
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };
        # Enable sound with pipewire.
        services.pulseaudio.enable = false;
        security.rtkit.enable = true;
        services.pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          # If you want to use JACK applications, uncomment this
          #jack.enable = true;

          # use the example session manager (no others are packaged yet so this is enabled by default,
          # no need to redefine it in your config for now)
          #media-session.enable = true;
        };
        users.users.yetso = {
          shell = pkgs.zsh;
          isNormalUser = true;
          description = "yetso";
          extraGroups = [ "networkmanager" "wheel" ];
          packages = with pkgs; [
            #  thunderbird
          ];
        };
        ##################


        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        nix.settings.trusted-users = [
          "root"
          "@admin"
        ];

        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;

        # Install firefox.
        programs.firefox.enable = true;
        # Install steam.
        programs.steam.enable = true;
        programs.steam.gamescopeSession.enable = true;
        environment.variables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/yetso/.steam/root/compatibilitytools.d";
        };
        programs.gamemode.enable = true;
        programs.neovim.enable = true;
        programs.neovim.defaultEditor = true;
        environment.systemPackages = with pkgs; [
          bat
          bottles
          cargo
          curl
          discord
          eza
          fastfetch
          podman
          fzf
          gcc
          git
          glibc
          gnumake
          ghostty
          gradle
          heroic
          lazygit
          lua
          lutris
          wget
          xsel
          zoxide
          zulu
        ];


        environment.shells = [ pkgs.zsh ];

        fonts.packages = with pkgs; [
          nerd-fonts.commit-mono
        ];

        # homebrew = {
        #   enable = true;
        #   onActivation.cleanup = "zap";
        #   onActivation.autoUpdate = true;
        #   onActivation.upgrade = true;
        #   brews = [ "curl" ];
        #   casks = [
        #     "appcleaner"
        #     "bitwarden"
        #     "brave-browser"
        #     "coteditor"
        #     "cyberghost-vpn"
        #     "firefox"
        #     "foxitreader"
        #     "ghostty"
        #     "latest"
        #     "onlyoffice"
        #     "qbittorrent"
        #     "skim"
        #     "spotify"
        #     "unnaturalscrollwheels"
        #     {
        #       name = "yetso/vesktop/vesktop";
        #       greedy = true;
        #     }
        #     "vlc"
        #     { name = "wezterm@nightly"; }
        #   ];
        #   taps = ["yetso/vesktop"];
        # };

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh = {
          enable = true;
          syntaxHighlighting.enable = true;
          enableBashCompletion = false;
          promptInit = "autoload -Uz promptinit && promptinit";
        };
        programs.fish.enable = false;

        system.stateVersion = "24.05";
        # nix.extraOptions = ''
        #   extra-platforms = x86_64-darwin aarch64-darwin
        # '';

      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          configuration
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.yetso = import ./home.nix;
          }
        ];
      };

    };
}
