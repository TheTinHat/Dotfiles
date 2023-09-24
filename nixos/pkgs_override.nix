{ config, ...}:
let
  unstableTarball =
    fetchTarball
      "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
in
{
  ### PACKAGES ### 
  # Add unstable package option
  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
