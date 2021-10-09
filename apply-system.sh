#!/bin/sh
pushd ~/.dotfiles/system/
sudo nixos-rebuild switch --flake .#
popd
