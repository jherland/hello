{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
  };

  outputs = inputs: let
      # nixbuild.net builds Linux derivations; list only those systems.
      systems = [ "x86_64-linux" "aarch64-linux" "i686-linux" "armv7l-linux"];
      forAllSystems = f: inputs.nixpkgs.lib.genAttrs systems (name: f name);
    in {
      packages = forAllSystems (system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        hello = pkgs.hello;
        default = pkgs.hello;
      });
      checks = forAllSystems (system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        inherit (pkgs) hello;

	hello-fail = pkgs.hello.overrideAttrs (_: {
	  postInstall = "exit 0";
	});
      });
  };
}
