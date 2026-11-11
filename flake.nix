{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
  };

  outputs = inputs: let
      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" "armv7l-linux" "aarch64-darwin" "x86_64-darwin"];
      forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems (name: f name);
    in {
      packages = forAllSystems (system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        hello = pkgs.hello;
        default = pkgs.hello;
      });
  };
}
