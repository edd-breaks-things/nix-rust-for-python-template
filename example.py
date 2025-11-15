#!/usr/bin/env python3
"""
Example usage of the Rust Python extension module.
Run 'maturin develop' first to build and install the module.
"""

import rust_python_example

def main():
    print("=" * 50)
    print("Rust + Python with PyO3 Examples")
    print("=" * 50)
    
    # Basic functions
    print("\n1. Basic arithmetic:")
    result = rust_python_example.add(5, 3)
    print(f"   add(5, 3) = {result}")
    
    result = rust_python_example.multiply(2.5, 4.0)
    print(f"   multiply(2.5, 4.0) = {result}")
    
    # String function
    print("\n2. String processing:")
    greeting = rust_python_example.greet("Python Developer")
    print(f"   {greeting}")
    
    # List processing
    print("\n3. List processing:")
    numbers = [1, 2, 3, 4, 5]
    doubled = rust_python_example.process_list(numbers)
    print(f"   Original: {numbers}")
    print(f"   Doubled:  {doubled}")
    
    # Class usage
    print("\n4. Using Rust class:")
    counter = rust_python_example.Counter()
    print(f"   Initial count: {counter.get_count()}")
    
    for i in range(3):
        counter.increment()
        print(f"   After increment {i+1}: {counter.get_count()}")
    
    counter.decrement()
    print(f"   After decrement: {counter.get_count()}")
    
    counter.reset()
    print(f"   After reset: {counter.get_count()}")
    
    # Performance example
    print("\n5. Performance comparison:")
    import time
    
    # Python version
    def python_sum(n):
        return sum(range(n))
    
    # Measure Python
    n = 1_000_000
    start = time.time()
    py_result = python_sum(n)
    py_time = time.time() - start
    
    print(f"   Python sum of 0..{n:,}: {py_result:,}")
    print(f"   Time: {py_time:.4f} seconds")
    
    print("\n" + "=" * 50)

if __name__ == "__main__":
    main()