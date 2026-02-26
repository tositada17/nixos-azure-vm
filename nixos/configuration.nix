{ modulesPath ,pkgs , ... }:

{
  # To build the configuration or use nix-env, you need to run
  # either nixos-rebuild --upgrade or nix-channel --update
  # to fetch the nixos channel.

  # This configures everything but bootstrap services,
  # which only need to be run once and have already finished
  # if you are able to see this comment.
  imports = [
   "${modulesPath}/virtualisation/azure-common.nix"
   "${modulesPath}/virtualisation/azure-image.nix"
  ];
  
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    vim
    git
    gh
    curl
    wget
    azure-cli
    nix-ld-rs
    neovim
  ];
  
  environment.variables.EDITOR = "neovim";
  users.users."nixos" = {
    isNormalUser = true;
    home = "/home/nixos";
    extraGroups = [ "wheel docker" ]; # Enable ‘sudo’ for the user.
  };

  programs = {
    nix-ld.enable = true;
  };

  services.waagent = {
    enable = true;
  };

  # Please set the VM Generation to the actual value
  virtualisation.azureImage.vmGeneration = "v2";
}
