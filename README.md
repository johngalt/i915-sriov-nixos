# Notes
Right now, this flake is **guest only**, but I may make a host module in the future.

# Installation
**READ**: If you do not want this to take 30+ minutes to compile, you should add the binary cache. Note that this should be done **before** you add the i915-sriov nixosModule.

For flakes, add this flake as an input, as such.
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

        # If you didn't read above, this MUST BE ADDED AND YOUR CONFIG REBUILT BEFORE ADDING THE NEXT MODULE if you don't want 30+ minute compile times
        i915-sriov-nixos.nixosModules.binary-cache

        # Did you read the comment above?
        i915-sriov-nixos.nixosModules.i915-sriov
      ];
    };
  };
}
```

# Attribution
The bulk of this config are from [vadika's NixOS config](https://github.com/vadika/nixos-config), but modified to work for guests instead.
