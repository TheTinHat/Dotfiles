{ pkgs, ... }:
{
  imports = [
    ../pkgs_override.nix
  ];

  environment.systemPackages = with pkgs; [
    flatpak
    gnome.gnome-tweaks
    element-desktop
    bitwarden
    firefox
    qgis
    libreoffice
    tor-browser-bundle-bin
    chromium
    steam
    inkscape
    gimp
    virt-manager
    wireshark
    vlc
    syncthing

    # Unstable
    unstable.prusa-slicer
    unstable.obsidian
    unstable.darktable
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs.steam.enable = true;

  services.syncthing = {
    enable = true;
    user = "david";
    dataDir = "/home/david/";
  };

  services.flatpak.enable = true;

}
