# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

   # Make ready for nix flakes
   nix.package = pkgs.nixFlakes;
   nix.extraOptions = ''
   experimental-features = nix-command flakes
  '';

  # Optimisation Nix store
   nix.settings.auto-optimise-store = true;

  #fish shell
  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # samba support
   boot.supportedFilesystems = [ "ntfs" ];
   services.gvfs.enable = true; # so that samba works
 
  # Kernal and non free support
   nixpkgs.config.allowUnfree = true;
   boot.kernelPackages =  pkgs.linuxPackages_latest;

  # Virtual machine setup
  # virtualisation.virtualbox.host.enable = true;
  # virtualisation.virtualbox.host.enableExtensionPack = true;
  # users.extraGroups.vboxusers.members = [ "greg" ];
 
 #Virt-Manager setup
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  users.extraGroups.libvirtd.members = [ "greg"];
 
 #sway setup
  programs.sway = {
  enable = true;
  wrapperFeatures.gtk = true; # so that gtk works properly
  extraPackages = with pkgs; [
    swaylock
    swayidle
    wl-clipboard
    mako # notification daemon
   # kitty # Alacritty is the default terminal in the config
    wofi # Dmenu is the default in the config but i recommend wofi since its wayland native
    autotiling    
    swaybg
    waybar
    wlogout    
      
    
  ];
};

 # Trezor setup
   services.trezord.enable = true;
      
 # Flatpak setup
   services.flatpak.enable = true;
   xdg.portal.enable = true;
  
 # Use the systemd-boot EFI boot loader.
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;

   networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
   time.timeZone = "Australia/Sydney";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.eno1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_AU.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "us";
   };

  # Enable the X11 windowing system.
   services.xserver.enable = true;


  # Enable the GNOME Desktop Environment.
  # services.xserver.displayManager.gdm.enable = true;
   services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.windowManager.openbox.enable = true;
  # services.gnome.games.enable = true;
   services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;
   services.printing.drivers = [ pkgs.brlaser ];

  # Enable sound.
   sound.enable = false;
   hardware.pulseaudio.enable = false;
  # rkit is optional but recomended
  security.rtkit.enable = true;
  services.pipewire = {     
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #If you want to use JACK applications, uncomment this line
    #jack.enable = true
    };
  
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.greg = {
   isNormalUser = true;
   extraGroups = [ "network manager" "wheel" ]; # Enable ‘sudo’ for the user.
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     firefox
     neofetch
     htop
     onedrive
     nmap
     git
     zoom-us
     lxqt.lxqt-policykit # For samba to work    
     libreoffice   
     appimage-run
     nomachine-client
     garmin-plugin
     qemu
     virt-manager
     qbittorrent
     pcmanfm
     mpv
     helix
            
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
   system.stateVersion = "unstable" # Did you read the comment?
;
 

}

