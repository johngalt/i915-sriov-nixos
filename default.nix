# From https://github.com/vadika/nixos-config/blob/e7c5ab289ea22e2d2f0fe30f21672d785400ece2/i915-iov.nix
{
  pkgs,
  lib,
  ...
}: let
  customKernel = pkgs.linux_6_12.override {
    structuredExtraConfig = with lib.kernel; {
      DRM_I915_PXP = yes;
      INTEL_MEI_PXP = module;
    };
  };

  customKernelPackages = pkgs.linuxPackagesFor customKernel;

  i915SRIOVModule = customKernelPackages.callPackage ./i915-sriov-dkms.nix {};
in {
  boot.kernelPackages = customKernelPackages;
  boot.extraModulePackages = [i915SRIOVModule];

  boot.blacklistedKernelModules = ["xe"];

  boot.kernelModules = ["i915-sriov"];
  boot.initrd.kernelModules = ["i915-sriov"];

  boot.extraModprobeConfig = ''
    options i915-sriov enable_guc=3
  '';

  boot.postBootCommands = ''
    /run/current-system/sw/bin/depmod -a ${customKernel.modDirVersion}
  '';

  hardware.graphics.extraPackages = with pkgs; [vaapiIntel intel-media-driver vpl-gpu-rt intel-ocl];
}
