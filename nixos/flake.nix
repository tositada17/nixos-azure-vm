{
  description = "flake ";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  outputs = { self, nixpkgs, ... }@inputs: {
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
