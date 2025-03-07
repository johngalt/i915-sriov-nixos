{
  linux_6_12,
  lib,
  ...
}:
linux_6_12.override {
  structuredExtraConfig = with lib.kernel; {
    DRM_I915_PXP = yes;
    INTEL_MEI_PXP = module;
  };
}
