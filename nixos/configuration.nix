{modulesPath, ...}:

{
  import = [
    "${modulesPath}/virtualisation/azure-common.nix"
    "${modulesPath}/virtualisation/azure-image.nix"
  ]

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  virtualisation.azure-image.vmGeneration = "v2"
}
