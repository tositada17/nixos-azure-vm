{username}:{
  _class,
  config,
  options,
  lib,
  modulesPath,
  pkgs,
  specialArgs,
}

:{
  imports =[
    "${modulesPath}/virtualisation/azure-image.nix"
  ];

  image.fileName = "nixos.vhd";
  virtualisation.azureImage.vmGeneration ="v2";
  virtualisation.diskSize = 32000; # 32GB
  
  system.stateVersion= "25.05";
  i18n.defaultLocale = "en_US.UTF-8";
  
  users.users."${username}" = {
    isNormalUser = true;
    home = "/home/${username}";
    extraGroups = [ "wheel docker" ]; # Enable ‘sudo’ for the user.
  };
  
  environment.systemPackages = with pkgs; [
    curl
    git
    vim
  ];
  
}
