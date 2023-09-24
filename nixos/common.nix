{ pkgs, ...}:

{
  imports =
    [ # Include the results of the hardware scan.
      <home-manager/nixos>
      ./pkgs_override.nix
      ./applications/tailscale.nix
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
    nerdfonts
    python311
    python311Packages.pip
    ripgrep
    rsync
    unzip
    wget
  ];

  system.stateVersion = "23.05"; 
}
