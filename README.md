# NixOS-Azure-VM  

## Purposes

- Minimal NixOS that running on AzureVM gen 2
- minimal flake file  that executable `nixos-rebuild swith` inside AzureVM
- NixOS launched by Self hosted Azure pipeline

## Installation

Prepare NixOS or nix flake environment.

1. Create Azure Account
2. Create Azure Blob Storage
3. create disk image ./result/nixos.vhd

    ```bash
    $ sudo nix build --flake ./flake.nix#azure-image
    ```

4. Upload `./result/nixos.vhd` to azure blob
5. Create VM Image from nixos.vhd in azure blob
6. Create VM Instance from the custom image created in step 5
7. create ssh file Azure VM

## Update NixOS

1. login VM Image
2. execute command

    ```bash
    $ sudo nixos-rebuild switch --flake .nixos/flake.nix#nixos
    ```

## Execute Azure pipeline Agent

1. install Azure pipeline Agent dependencies.  
  krb5,zlib,icu,dotnet6 enviroment... and more check /nixos/configuration.nix
 
    ```bash
    $ sudo nixos-rebuild switch --flake .nixos/flake.nix#nixos
    ```

2. download Azure pipeline Agent.
3. execute `bash ./env.sh` start azure pipeline agent settings.
4. execute `bash ./run.sh`
