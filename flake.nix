{
  description = "NixOS configuration and Home Manager configuration"; 
    inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };  outputs = { home-manager, nixpkgs, ... }: {
    nixosConfigurations.nixos = {
      nixtst = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
       config = { allowUnfree = true; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mudrii = import ./users/greg/home.nix;
          }
        ];
      };
    };
  };
}
