///|
using @python {type PyModule, type PyTuple, type PyFloat}

///|
pub struct TimeModule {
  priv time : PyModule
}

///|
pub suberror TurtleError {
  LoadTimeModuleError
} derive(Show)

///|
fn new() -> TimeModule raise Error {
  guard @python.pyimport("time") is Some(time) else {
    raise LoadTimeModuleError
  }
  TimeModule::{ time, }
}

///|
let singleton : () -> TimeModule = get_lib()

///|
fn get_lib() -> () -> TimeModule {
  @python.init_py()
  let lib = new() catch {
    e => {
      println(e)
      panic()
    }
  }
  fn() { lib }
}

///|
pub fn sleep(seconds : Double) -> Unit {
  let lib = singleton()
  guard lib.time.get_attr("sleep") is Some(PyCallable(f))
  let args = PyTuple::new(1)
  args..set(0, PyFloat::from(seconds))
  let _ = try? f.invoke(args~)
  ()
}

///|
/// Returns the time in seconds since the epoch as a floating-point number.
/// Corresponds to `time.time()` in Python.
pub fn time() -> Double {
  let lib = singleton()
  guard lib.time.get_attr("time") is Some(PyCallable(f)) else {
    // Consider how to handle errors, e.g., return a specific error or panic
    println("Error: Could not get time.time function") // Placeholder error value
    return 0.0
  }
  guard (try? f.invoke()).unwrap() is Some(PyFloat(t)) else {
    println("Error: time.time did not return a float") // Placeholder error value
    return 0.0
  }
  t.to_double()
}

///|
/// Returns the time in nanoseconds since the epoch as an integer.
/// Corresponds to `time.time_ns()` in Python.
pub fn time_ns() -> Int64 {
  let lib = singleton()
  guard lib.time.get_attr("time_ns") is Some(PyCallable(f)) else {
    println("Error: Could not get time.time_ns function") // Placeholder error value
    return 0L
  }
  guard (try? f.invoke()).unwrap() is Some(PyInteger(t)) else {
    println("Error: time.time_ns did not return an integer") // Placeholder error value
    return 0L
  }
  t.to_int64()
}

///|
/// Returns the value (in fractional seconds) of a monotonic clock.
/// Corresponds to `time.monotonic()` in Python.
pub fn monotonic() -> Double {
  let lib = singleton()
  guard lib.time.get_attr("monotonic") is Some(PyCallable(f)) else {
    println("Error: Could not get time.monotonic function")
    return 0.0
  }
  guard (try? f.invoke()).unwrap() is Some(PyFloat(t)) else {
    println("Error: time.monotonic did not return a float")
    return 0.0
  }
  t.to_double()
}

///|
/// Returns the value (in nanoseconds) of a monotonic clock.
/// Corresponds to `time.monotonic_ns()` in Python.
pub fn monotonic_ns() -> Int64 {
  let lib = singleton()
  guard lib.time.get_attr("monotonic_ns") is Some(PyCallable(f)) else {
    println("Error: Could not get time.monotonic_ns function")
    return 0L
  }
  guard (try? f.invoke()).unwrap() is Some(PyInteger(t)) else {
    println("Error: time.monotonic_ns did not return an integer")
    return 0L
  }
  t.to_int64()
}

///|
/// Returns the value (in fractional seconds) of a performance counter.
/// Corresponds to `time.perf_counter()` in Python.
pub fn perf_counter() -> Double {
  let lib = singleton()
  guard lib.time.get_attr("perf_counter") is Some(PyCallable(f)) else {
    println("Error: Could not get time.perf_counter function")
    return 0.0
  }
  guard (try? f.invoke()).unwrap() is Some(PyFloat(t)) else {
    println("Error: time.perf_counter did not return a float")
    return 0.0
  }
  t.to_double()
}

///|
/// Returns the value (in nanoseconds) of a performance counter.
/// Corresponds to `time.perf_counter_ns()` in Python.
pub fn perf_counter_ns() -> Int64 {
  let lib = singleton()
  guard lib.time.get_attr("perf_counter_ns") is Some(PyCallable(f)) else {
    println("Error: Could not get time.perf_counter_ns function")
    return 0L
  }
  guard (try? f.invoke()).unwrap() is Some(PyInteger(t)) else {
    println("Error: time.perf_counter_ns did not return an integer")
    return 0L
  }
  t.to_int64()
}

///|
/// Returns the value (in fractional seconds) of the sum of the system and user CPU time of the current process.
/// Corresponds to `time.process_time()` in Python.
pub fn process_time() -> Double {
  let lib = singleton()
  guard lib.time.get_attr("process_time") is Some(PyCallable(f)) else {
    println("Error: Could not get time.process_time function")
    return 0.0
  }
  guard (try? f.invoke()).unwrap() is Some(PyFloat(t)) else {
    println("Error: time.process_time did not return a float")
    return 0.0
  }
  t.to_double()
}

///|
/// Returns the value (in nanoseconds) of the sum of the system and user CPU time of the current process.
/// Corresponds to `time.process_time_ns()` in Python.
pub fn process_time_ns() -> Int64 {
  let lib = singleton()
  guard lib.time.get_attr("process_time_ns") is Some(PyCallable(f)) else {
    println("Error: Could not get time.process_time_ns function")
    return 0L
  }
  guard (try? f.invoke()).unwrap() is Some(PyInteger(t)) else {
    println("Error: time.process_time_ns did not return an integer")
    return 0L
  }
  t.to_int64()
}

///|
/// Converts a time expressed in seconds since the epoch to a string representing local time.
/// If `secs_option` is `None`, the current time as returned by `time()` is used.
/// Corresponds to `time.ctime([secs])` in Python.
pub fn ctime(secs_option : Double?) -> String {
  let lib = singleton()
  guard lib.time.get_attr("ctime") is Some(PyCallable(f)) else {
    println("Error: Could not get time.ctime function") // Placeholder error value
    return ""
  }
  let result = match secs_option {
    Some(secs) => {
      let args = PyTuple::new(1)
      args..set(0, PyFloat::from(secs))
      (try? f.invoke(args~)).unwrap()
    }
    None => (try? f.invoke()).unwrap() // Call without arguments
  }
  guard result is Some(PyString(s)) else {
    println("Error: time.ctime did not return a string") // Placeholder error value
    return ""
  }
  s.to_string()
}
