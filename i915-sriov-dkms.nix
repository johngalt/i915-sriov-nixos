{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  # xz,
  ...
}:
stdenv.mkDerivation rec {
  pname = "i915-sriov-dkms";
  version = "2025.05.11";

  src = fetchFromGitHub {
    owner = "strongtz";
    repo = "i915-sriov-dkms";
    rev = version;
    sha256 = "sha256-1MlNNzNhxAkffnJ3eBh6nhXQIBsGH5ROIOyOlxsU8Qs=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M=$(pwd) \
      KERNELRELEASE=${kernel.modDirVersion}
  '';

  # Use this install phase to overwrite default i915 module to force the custom one to load
  installPhase = ''
    install -D i915.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/gpu/drm/i915/i915.ko
  '';

  # installPhase = ''
  #   mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
  #   # ${xz}/bin/xz -z -f i915.ko
  #   cp i915.ko.xz $out/lib/modules/${kernel.modDirVersion}/extra/i915-sriov.ko.xz
  # '';

  meta = {
    description = "Custom module for i915 SRIOV support";
    homepage = "https://github.com/strongtz/i915-sriov-dkms";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
  };
}
