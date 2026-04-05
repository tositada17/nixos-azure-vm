{
  pkgs ? import <nixpkgs> {},
  lib,
  stdenv,
  icu,
  krb5,
  zlib,
  lttng-ust,
  openssl_3,
  dotnetCorePackages
}:

let
  unpacked = stdenv.mkDerivation {
    pname = "azure-pipelines-agent";
    version = "4.269.0" ;

    src = ./vsts-agent-linux-x64-4.269.0.tar.gz;
    sourceRoot = ".";
    
    buildInputs = [
      icu
      krb5
      zlib
      lttng-ust
      openssl_3
      dotnetCorePackages.runtime_8_0-bin
    ];
    
    installPhase = ''
      mkdir $out
      cp -r $sourceRoot $out
    '';

    # meta.mainProgram = "run.sh";
    
};

LinuxGetDependencies =
  pkgs:
  [
    pkgs.icu
    pkgs.krb5
    pkgs.zlib
    pkgs.lttng-ust
    pkgs.openssl_3
    pkgs.dotnetCorePackages.runtime_8_0-bin
  ];
in

unpacked
