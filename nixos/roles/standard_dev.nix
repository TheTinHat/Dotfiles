{ pkgs, ... }:
{
  imports = [ ../pkgs_override.nix ];

  environment.systemPackages = with pkgs; [
    nmap
    nodejs_20
    python311
    python311Packages.pip
    terraform
    vscodium
    go
    gopls 
    gotools 
    go-tools
  ];
}
