#!/usr/bin/env bash

function check_continue {
	read -rp "$1 (y/N) " yn
	if [ "$yn" != "y" ]; then
		exit 1
	fi
}

if test -f "hosts/$(hostname)/configuration.nix"; then
	check_continue "Replace /etc/nixos/configuration.nix?"

	sudo ln -sf "$HOME/Dotfiles/nixos/hosts/$(hostname)/configuration.nix /etc/nixos/configuration.nix"

else
	echo "Cannot find 'hosts/$(hostname)/configuration.nix'"
fi

if check_continue "Create root ssh key and copy to admin@192.168.1.200?"; then
	sudo ssh-keygen -N '' -f ~/.ssh/id_rsa
	sudo ssh-copy-id admin@192.168.1.200
fi
