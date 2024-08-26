{
  description = "A simple systemd service to better control Framework Laptop's fan(s)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, flake-compat }: {
    packages.x86_64-linux.default = self.packages.x86_64-linux.fw-fanctrl;
    packages.x86_64-linux.fw-fanctrl = (
      import nixpkgs {
        currentSystem = "x86_64-linux";
        localSystem = "x86_64-linux";
      }).pkgs.callPackage ./nix/packages/fw-fanctrl.nix {};
      
    packages.x86_64-linux.fw-fanctrl-gui = (
      import nixpkgs {
        currentSystem = "x86_64-linux";
        localSystem = "x86_64-linux";
      }).pkgs.callPackage ./nix/packages/fw-fanctrl-gui.nix {};

    nixosModules.default = import ./nix/module.nix;
  };
}
