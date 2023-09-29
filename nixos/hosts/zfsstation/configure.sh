#!/bin/bash

sudo nix run github:nix-community/disko --extra-experimental-features nix-command --extra-experimental-features flakes -- --mode disko ./disko-config.nix

sudo nixos-generate-config --no-filesystems --root /mnt

sudo cp configuration.nix /mnt/etc/nixos/
sudo cp disko-config.nix /mnt/etc/nixos/

sudo nixos-install
