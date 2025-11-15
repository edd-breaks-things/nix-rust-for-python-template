use pyo3::prelude::*;

#[pyfunction]
fn add(a: i64, b: i64) -> PyResult<i64> {
    Ok(a + b)
}

#[pyfunction]
fn multiply(a: f64, b: f64) -> PyResult<f64> {
    Ok(a * b)
}

#[pyfunction]
fn greet(name: &str) -> PyResult<String> {
    Ok(format!("Hello, {}! From Rust with love 🦀", name))
}

#[pyclass]
struct Counter {
    count: i32,
}

#[pymethods]
impl Counter {
    #[new]
    fn new() -> Self {
        Counter { count: 0 }
    }

    fn increment(&mut self) {
        self.count += 1;
    }

    fn decrement(&mut self) {
        self.count -= 1;
    }

    fn get_count(&self) -> i32 {
        self.count
    }

    fn reset(&mut self) {
        self.count = 0;
    }
}

#[pyfunction]
fn process_list(items: Vec<i32>) -> PyResult<Vec<i32>> {
    Ok(items.iter().map(|x| x * 2).collect())
}

#[pymodule]
fn rust_python_example(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(add, m)?)?;
    m.add_function(wrap_pyfunction!(multiply, m)?)?;
    m.add_function(wrap_pyfunction!(greet, m)?)?;
    m.add_function(wrap_pyfunction!(process_list, m)?)?;
    m.add_class::<Counter>()?;
    Ok(())
}