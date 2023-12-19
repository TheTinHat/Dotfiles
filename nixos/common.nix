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

  users.users.david = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "docker" "libvirtd" ];
  };

  security.sudo.extraRules = [
    { users = [ "david" ];
      commands = [
        {
          command = "ALL";
	        options = [ "NOPASSWD" ];
	      }
      ];
    }
  ];

  environment.systemPackages = with pkgs; [
    curl
    gcc
    git
    htop
    ripgrep
    rsync
    tailscale
    unzip
    wget
  ];

  services.tailscale.enable = true;

  system.stateVersion = "23.11"; 
}
