{
  description = "dotnet restore with lock";
  
  inputs = {

    nixpkgs = {
      # url = "github:nixos/nixpkgs?ref=master";
      url = "github:anpin/nixpkgs?ref=next";

    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
    let 
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system ; };
    inherit (inputs.nixpkgs) lib; 
    in {
      packages.${system}.default = pkgs.callPackage ./Cli {};
      devShells.${system}.default = import ./shell.nix {inherit pkgs;};

      apps.${system} = with pkgs; {
          make-deps = {
              type = "app";
                program = toString (pkgs.writers.writeBash "make-deps" ''
                  tmp=$(realpath "$(mktemp -td run-nuget-to-nix.XXXXXX)")
                  mkdir -p $tmp/packages
                  ${dotnet-sdk_8}/bin/dotnet restore -v d --packages $tmp/packages -r:linux-x64
                  ${nuget-to-nix}/bin/nuget-to-nix $tmp/packages > deps.nix
                '');
          };
      };
  };
}
