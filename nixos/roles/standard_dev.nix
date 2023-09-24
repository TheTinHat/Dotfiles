{ pkgs, ...}:
{
  imports = [../pkgs_override.nix];

  environment.systemPackages = with pkgs; [
    python311
    python311Packages.pip
    terraform
    nmap
    nodejs_20
  ];
}
