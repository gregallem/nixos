#!/bin/sh
pushd ~/.dotfiles
home-manager switch -f ./users/greg/home.nix
popd
