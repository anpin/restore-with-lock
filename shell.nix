{ pkgs  } : with pkgs;
mkShell {
 packages = [
   dotnet-sdk_8
   nuget-to-nix
  ];
}
