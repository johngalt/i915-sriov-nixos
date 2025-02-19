{
  description = "NixOS module which provides a kernel and dkms module for i915 SR-IOV";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/a0f3e10d94359665dba45b71b4227b0aeb851f8e";
  };

  outputs = {...}: {
    nixosModules = {
      i915-sriov = ./default.nix;
    };
  };
}
