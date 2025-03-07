{...}: {
  nix.settings = {
    trusted-substituters = ["https://i915-sriov-nixos.cachix.org"];
    trusted-public-keys = ["i915-sriov-nixos.cachix.org-1:bFZXGGh8AjLUAbY31t3qYiCnylsI/W46ul3pe3Maibg="];
  };
}
