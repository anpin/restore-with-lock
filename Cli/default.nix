{ lib
, buildDotnetModule
, dotnet-sdk_8
}:
buildDotnetModule rec {
  dotnet-sdk = dotnet-sdk_8;
  pname = "Cli";
  packNupkg = true;
  version  = "0.0.1";
  src = ./.;
  projectFile = [
      "Cli.fsproj"
  ];
  nugetDeps = ../deps.nix;
  meta = with lib; {
    homepage = "https://github.com/anpin/restore-with-lock";
    description = "Repro for lock restore";
    license = licenses.mit;
    maintainers = with maintainers; [ anpin ];
    platforms = [ "x86_64-linux" "aarch64-linux" ];
  };
}
