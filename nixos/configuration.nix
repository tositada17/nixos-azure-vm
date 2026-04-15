{ modulesPath ,pkgs , inputs,... }:

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
    # icu inside dotnet sdk
    krb5
    zlib
    lttng-ust
    openssl_3
    nodejs_20
    gcc
    libgcc
    cmake
    extra-cmake-modules
    zlib
   ];

  nixpkgs.config.permittedInsecurePackages = with pkgs; [
    dotnet-sdk_6
    dotnet-runtime_6
  ];

  environment.variables.EDITOR = "neovim";
  environment.variables.LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.icu}/lib:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.zlib}/lib";
  users.users."nixos" = {
    isNormalUser = true;
    home = "/home/nixos";
    extraGroups = [ "wheel docker" ]; # Enable ‘sudo’ for the user.
  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib
      icu
    ];
  };

  services.waagent = {
    enable = true;
  };

  # Please set the VM Generation to the actual value
  virtualisation.azureImage.vmGeneration = "v2";
}
