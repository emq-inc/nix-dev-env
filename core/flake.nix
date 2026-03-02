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
        # Use erlang_27 to match .tool-versions: erlang 27.2
        beamPackages = pkgs.beam.packages.erlang_27;
        erlang = beamPackages.erlang;
        # elixir_1_19 built against OTP 27, matching .tool-versions: elixir 1.19.0-otp-27
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
