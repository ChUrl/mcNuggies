{
  description = "Flake for mcNuggies shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.devshell.url = "github:numtide/devshell";

  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [ devshell.overlay ];
        };
      in {
        devShell = pkgs.devshell.mkShell {
          name = "mcNuggies";

          packages = with pkgs; [
            packwiz
          ];

          commands = [
            {
              name = "add";
              help = "Add a curseforge mod to the pack";
              command = "packwiz curseforge add $1";
            }
          ];
        };
      });
}
