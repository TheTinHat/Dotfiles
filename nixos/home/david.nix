{ pkgs, ...}:
{
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

  home-manager.users.david = { ... }: {
    home.packages = with pkgs; [
      # Utilities 
      terraform
      nmap
      nodejs_20
      flatpak
      syncthing

      # Desktop
      gnome.gnome-tweaks
      element-desktop
      bitwarden
      firefox
      qgis
      libreoffice
      tor-browser-bundle-bin
      chromium
      vscodium
      steam
      inkscape
      gimp
      virt-manager
      wireshark
      vlc
      
      # Unstable
      unstable.prusa-slicer
      unstable.obsidian
      unstable.darktable
    ];

    home.file.".config" = {
      source = ../../config;
      recursive = true;
    };
    
    programs.bash = {
      enable = true;
      shellAliases = {
        nrs = "sudo nixos-rebuild switch";
        ec = "nvim /home/david/Dotfiles/";
        work = "source env/bin/activate";
        mkenv = "python3 -m venv env";
        alfred = "ssh alfred@192.168.1.201";
        nas = "ssh admin@192.168.1.200";
        myip = "curl ifconfig.me && echo -e ''";
      };
    };

    programs.git = {
      enable = true;
      userName = "David Swanlund";
      userEmail = "10473778+TheTinHat@users.noreply.github.com";
    };
  
    programs.gnome-terminal.themeVariant = "dark";

    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 43200;
      enableSshSupport = true;
    };

    home.stateVersion = "23.05";   
  };

  services.syncthing = {
    enable = true;
    user = "david";
    dataDir = "/home/david/";
  };

  }
