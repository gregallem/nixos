#!/bin/sh
pushd ~/.dotfiles/nixos/
sudo nixos-rebuild switch --flake .#
popd
