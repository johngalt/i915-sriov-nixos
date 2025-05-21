{
  linux_6_12_28,
  lib,
  ...
}:

linux_6_12_28.override {
  structuredExtraConfig = with lib.kernel; {
    DRM_I915_PXP = yes;
    INTEL_MEI_PXP = module;
  };
}
