# From https://github.com/vadika/nixos-config/blob/e7c5ab289ea22e2d2f0fe30f21672d785400ece2/i915-iov.nix
{
  pkgs,
  lib,
  customKernel,
  i915SRIOVModule,
  ...
}: let
  customKernelPackages = pkgs.linuxPackagesFor customKernel;
in {
  boot.kernelPackages = customKernelPackages;
  boot.extraModulePackages = [i915SRIOVModule];

  boot.blacklistedKernelModules = ["xe"];

  # boot.kernelModules = ["i915-sriov"];
  # boot.initrd.kernelModules = ["i915-sriov"];

  # boot.extraModprobeConfig = ''
  #   options i915-sriov enable_guc=3
  # '';

  # boot.postBootCommands = ''
  #   /run/current-system/sw/bin/depmod -a ${customKernel.modDirVersion}
  # '';
}
