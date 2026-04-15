{
  description = "flake ";

  inputs = {
    # NixOS official package source, here using the nixos-25.05 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs,... }@inputs: 
  let
    system = "x86_64-linux";
  in
 
  {
   # The host with the hostname `nixos` will use this configuration

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
      };
    };
  };
}
