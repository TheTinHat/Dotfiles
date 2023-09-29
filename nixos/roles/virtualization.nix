{ pkgs, ... }:
{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    OVMFFull
  ];
}
