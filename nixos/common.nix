{ pkgs, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./pkgs_override.nix
      ./applications/neovim.nix
    ];

  time.timeZone = "America/Vancouver";
  i18n.defaultLocale = "en_CA.UTF-8";

  environment.systemPackages = with pkgs; [
    curl
    flatpak
    gcc
    git
    htop
    python311
    python311Packages.pip
    ripgrep
    rsync
    tailscale
    unzip
    wget
  ];

  programs.git = {
    enable = true;
    userName = "David Swanlund";
    userEmail = "10473778+TheTinHat@users.noreply.github.com";
  };
  
  services.tailscale.enable = true;

  system.stateVersion = "23.05"; 
}
