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
        buildInputs = with pkgs; [
          pkgs.nixgl.nixGLIntel
          pkgs.ffmpeg
        ];

        packages = with pkgs; [
          julia-bin
          gr-framework
          stdenv.cc.cc.lib qt5.qtbase qt5Full libGL
          glxinfo
          glfw
          stdenv.cc.cc
          
        ];

        NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
          pkgs.stdenv.cc.cc
          pkgs.ffmpeg
        ];

        NIX_LD = builtins.readFile "${pkgs.stdenv.cc}/nix-support/dynamic-linker";

        shellHook = ''
          julia --version 
          nixGLIntel julia
        '';
        
      };
      
    };
}
