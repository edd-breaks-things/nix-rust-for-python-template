{
  description = "Rust + Python development environment with PyO3";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = { self, nixpkgs, flake-utils, rust-overlay, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" ];
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            # Rust toolchain
            rustToolchain
            
            # Python with dev headers
            python311
            python311.pkgs.pip
            python311.pkgs.setuptools
            
            # Build tools for PyO3
            maturin
            pkg-config
            
            # Optional tools
            git
          ];
          
          shellHook = ''
            # Set Python for PyO3
            export PYO3_PYTHON="${pkgs.python311}/bin/python"
            
            # Create and activate a virtual environment if it doesn't exist
            if [ ! -d .venv ]; then
              echo "Creating virtual environment..."
              ${pkgs.python311}/bin/python -m venv .venv
            fi
            
            # Activate the virtual environment
            source .venv/bin/activate
            
            # Ensure Python can find the built module
            export PYTHONPATH="$PWD:$PYTHONPATH"
            
            echo "🦀 PyO3 Rust-Python Development Environment (Flake)"
            echo "===================================================="
            echo "Python: $(python --version)"
            echo "Rust:   $(rustc --version)"
            echo "Maturin: $(maturin --version)"
            echo ""
            echo "Quick start:"
            echo "  1. Build: maturin develop"
            echo "  2. Test:  python example.py"
          '';
        };
      });
}