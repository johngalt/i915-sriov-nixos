{
  stdenv,
  lib,
  fetchFromGitHub,
  kernel,
  xz,
  ...
}:
stdenv.mkDerivation rec {
  pname = "i915-sriov-dkms";
  version = "2025.02.03";

  src = fetchFromGitHub {
    owner = "strongtz";
    repo = "i915-sriov-dkms";
    rev = version;
    sha256 = "sha256-bBcV4Na1VVlw8ftCg6SPG+levrhsxZFJ2BKna5Ar2EQ=";
  };

  nativeBuildInputs = kernel.moduleBuildDependencies ++ [xz];

  makeFlags = [
    "KERNELRELEASE=${kernel.modDirVersion}"
    "KERNEL_DIR=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
  ];

  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M=$(pwd) \
      KERNELRELEASE=${kernel.modDirVersion}
  '';

  installPhase = ''
    mkdir -p $out/lib/modules/${kernel.modDirVersion}/extra
    ${xz}/bin/xz -z -f i915.ko
    cp i915.ko.xz $out/lib/modules/${kernel.modDirVersion}/extra/i915-sriov.ko.xz
  '';

  meta = {
    description = "Custom module for i915 SRIOV support";
    homepage = "https://github.com/strongtz/i915-sriov-dkms";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
  };
}
