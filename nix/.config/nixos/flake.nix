{
  description = "Yetso's nixos flake config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      configuration = { pkgs, config, lib, ... }: {
        imports = [
          # Include the results of the hardware scan.
          ./hardware-configuration.nix
        ];

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

        fonts.packages = with pkgs; [
          (nerdfonts.override { fonts = [ "CommitMono" ]; })
        ];

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
            intelBusId = "PCI:0:0:0";
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
        hardware.pulseaudio.enable = false;
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

        # Allow unfree packages
        nixpkgs.config.allowUnfree = true;

        # Install firefox.
        programs.firefox.enable = true;
        # Install steam.
        programs.steam.enable = true;
        programs.steam.gamescopeSession.enable = true;
        programs.gamemode.enable = true;
        environment.sessionVariables = {
          STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/yetso/.steam/root/compatibilitytools.d";
        };

        programs.neovim.enable = true;
        programs.neovim.defaultEditor = true;
        programs.fish.enable = true;

        environment.systemPackages = with pkgs; [
          bat
          bottles
          cargo
          curl
          discord
          eza
          fastfetch
          fzf
          gcc
          git
          glibc
          gnumake
          heroic
          lazygit
          lua
          lutris
          # neovim
          protonup
          python3
          starship
          stow
          wezterm
          wget
          xsel
          zoxide
          kdePackages.partitionmanager
          kcalc
        ];

        nix.settings.experimental-features = [ "nix-command" "flakes" ];
        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.yetso = {
          shell = pkgs.fish;
          isNormalUser = true;
          description = "yetso";
          extraGroups = [ "networkmanager" "wheel" ];
          packages = with pkgs; [
            #  thunderbird
          ];
        };

        # This value determines the NixOS release from which the default
        # settings for stateful data, like file locations and database versions
        # on your system were taken. It‘s perfectly fine and recommended to leave
        # this value at the release version of the first install of this system.
        # Before changing this value read the documentation for this option
        # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
        system.stateVersion = "24.05"; # Did you read the comment?
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
