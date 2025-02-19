{
  description = "NixOS module which provides a kernel and dkms module for i915 SR-IOV";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/a0f3e10d94359665dba45b71b4227b0aeb851f8e";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    customKernel = pkgs.callPackage ./kernel.nix {};
    i915SRIOVModule = (pkgs.linuxPackagesFor customKernel).callPackage ./i915-sriov-dkms.nix {};
  in {
    nixosModules = {
      i915-sriov = import ./default.nix {inherit customKernel i915SRIOVModule;};
    };

    packages.x86_64-linux = {
      default = i915SRIOVModule;
      kernel = customKernel;
    };
  };
}
