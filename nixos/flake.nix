{
description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    
  };


  outputs = { self, nixpkgs, ... }: {
    # replace 'joes-desktop' with your hostname here.
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
       system = "x86_64-linux";
       modules = [ ./configuration.nix ];
    };
  };
}
