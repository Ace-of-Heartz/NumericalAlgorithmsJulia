{ 
  description = "Julia project flake";

  inputs = {
    nixgl.url = "github:nix-community/nixGL";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };
  outputs = { self, nixgl, nixpkgs }:
    let 
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system; 
        overlays = [nixgl.overlay];
      };
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nixgl.nixGLIntel
        ];

        packages = with pkgs; [
          julia-bin
          gr-framework
          stdenv.cc.cc.lib qt5.qtbase qt5Full libGL
          glxinfo
          glfw
          ffmpeg
        ];

        shellHook = ''
          julia --version 
          nixGLIntel julia
        '';
      };
      
    };
}
