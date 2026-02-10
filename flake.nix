{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = inputs@{ nixpkgs, ... }:let 
    username = "nixos";
    system = "x86_64-linux";
    forAllSystem = nixpkgs.lib.genAttrs ["aarch64-linux" "x86_64-linux"];
  in 
  {
    packages.${system}={
      azure-image = 
        ( nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            (import ./build/configuration.nix { inherit username;})
          ];
        }).config.system.build.azureImage;
    };
  };
}
