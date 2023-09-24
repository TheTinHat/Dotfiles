{ ...}:
{
  home-manager.users.david = { ... }: {
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
        alfred = "ssh alfred@alfred.wolf-atlas.ts.net";
        rust = "ssh admin@rust.wolf-atlas.ts.net";
        myip = "curl ifconfig.me && echo -e ''";
      };
    };

    programs.git = {
      enable = true;
      userName = "David Swanlund";
      userEmail = "10473778+TheTinHat@users.noreply.github.com";
    };
  
    services.gpg-agent = {
      enable = true;
      defaultCacheTtl = 43200;
      enableSshSupport = true;
    };

    home.stateVersion = "23.05";   
  };

  }
