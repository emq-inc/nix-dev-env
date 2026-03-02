{
  description = "EMQ Core development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        beamPackages = pkgs.beam.packages.erlang_27;
        erlang = beamPackages.erlang;
        elixir = beamPackages.elixir_1_19;
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            erlang
            elixir
          ];
        };
      }
    );
}
