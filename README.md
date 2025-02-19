# Notes
Right now, this flake is **guest only**, but I may make a host module in the future.

# Installation
For flakes, add this flake as an input, as such:
```nix
{
  ... # Description and other flake attributes

  inputs = {
    ... # More inputs

    i915-sriov-nixos.url = "github:corbinwunderlich/i915-sriov-nixos # IMPORTANT: read below

    ... # Even more inputs...
  };

  outputs = inputs @ {
    i915-sriov-nixos,
    ... # The inputs you want quickly accessible...
  }: {
    nixosConfigurations.HOSTNAME = inputs.nixpkgs.lib.nixosSystem {
      ... # Your specialArgs, system architecture, etc...

      modules = [
        ... # More modules like home manager and your configuration.nix

        i915-sriov-nixos.nixosModules.i915-sriov
      ];
    };
  };
}
```

Unless you know what you are doing, are a gentoo user, or are _desperate_ to save 40MB on your disk, you can override the nixpkgs input for this flake, with `i915-sriov-nixos.inputs.nixpkgs.follows = "nixpkgs"`.
However, this will invalidate the binary cache that the flake adds, so you will have to wait a while (30 mins on a fast CPU) for the kernel and dkms module to recompile.

# Attribution
The bulk of this config are from [vadika's NixOS config](https://github.com/vadika/nixos-config), but modified to work for guests instead.
