{  ...}:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../common.nix
      ../../home/david.nix
    ];


  ### BOOT ###
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Setup keyfile
  boot.initrd.secrets = {
    "/crypto_keyfile.bin" = null;
  };

  # Enable swap on luks
  boot.initrd.luks.devices."luks-3538d39a-6a5b-481e-a85a-f25141900c7b".device = "/dev/disk/by-uuid/3538d39a-6a5b-481e-a85a-f25141900c7b";
  boot.initrd.luks.devices."luks-3538d39a-6a5b-481e-a85a-f25141900c7b".keyFile = "/crypto_keyfile.bin";


  ### NETWORKING ###
  networking.hostName = "nixstation"; # Define your hostname.
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false; # Disables firewall entirely

  ### SERVICES ###
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "david";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  services.flatpak.enable = true;
  

  ### AUDIO ###
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true; # Enables JACK applications
    #media-session.enable = true;
  };

  ### VIRTUALIZATION ###
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  virtualisation.docker.enable = true;

}
