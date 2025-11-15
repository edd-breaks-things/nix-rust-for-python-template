# Nix + Rust + Python Template with PyO3

[![CI](https://github.com/edd-builds-things/nix-rust-for-python-template/actions/workflows/ci.yml/badge.svg)](https://github.com/edd-builds-things/nix-rust-for-python-template/actions/workflows/ci.yml)

A simple template for developing Rust extensions for Python using PyO3 and Nix.

## Quick Start

1. **Enter the Nix development environment:**
   ```bash
   nix develop
   ```
   
   Or with direnv:
   ```bash
   direnv allow
   ```

2. **Build the Rust extension:**
   ```bash
   maturin develop
   ```

3. **Run the example:**
   ```bash
   python example.py
   ```

## Project Structure

```
nix-rust-for-python-template/
├── flake.nix           # Nix flake configuration
├── .envrc              # Direnv configuration (auto-loads flake)
├── Cargo.toml          # Rust project configuration
├── pyproject.toml      # Python packaging configuration
├── src/
│   └── lib.rs          # Rust source code with PyO3 bindings
└── example.py          # Python example using the Rust module
```

## What's Included

### Rust Functions
- `add(a, b)` - Add two integers
- `multiply(a, b)` - Multiply two floats
- `greet(name)` - Return a greeting string
- `process_list(items)` - Double all items in a list

### Rust Class
- `Counter` - A simple counter class with increment/decrement/reset methods

## Development Workflow

1. **Make changes to Rust code** in `src/lib.rs`
2. **Rebuild** with `maturin develop`
3. **Test** your changes with Python

### Building for Release

```bash
maturin build --release
```

### Running Tests

Create a `tests/` directory with Python tests:

```python
# tests/test_example.py
import rust_python_example

def test_add():
    assert rust_python_example.add(2, 3) == 5

def test_counter():
    counter = rust_python_example.Counter()
    counter.increment()
    assert counter.get_count() == 1
```

Run with pytest:
```bash
pip install pytest
pytest tests/
```

## Tips

- The Nix flake provides a reproducible development environment
- `maturin develop` installs the module in development mode (editable)
- Use `cargo check` for fast type checking without building
- Use `cargo clippy` for linting
- The `PYO3_PYTHON` environment variable is automatically set by the Nix environment

## Adding Dependencies

### Rust Dependencies
Add to `Cargo.toml`:
```toml
[dependencies]
pyo3 = { version = "0.20", features = ["extension-module"] }
serde = "1.0"  # Example additional dependency
```

### Python Dependencies
Install in the Nix environment with pip:
```bash
pip install numpy pandas
```

Or add to `flake.nix` for reproducibility:
```nix
python311.pkgs.numpy
python311.pkgs.pandas
```

## Troubleshooting

- **Import error**: Make sure you've run `maturin develop` after changes
- **Rust compilation errors**: Check `cargo build` output
- **Python version mismatch**: Ensure you're using the Python from the Nix environment
- **Nix flake issues**: Run `nix flake update` to update dependencies

## Resources

- [PyO3 Documentation](https://pyo3.rs/)
- [Maturin Documentation](https://maturin.rs/)
- [Nix Manual](https://nixos.org/manual/nix/stable/)