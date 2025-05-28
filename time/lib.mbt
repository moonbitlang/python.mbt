///|
typealias PyModule = @python.PyModule

///|
//typealias PyObject = @python.PyObject

///|
typealias PyTuple = @python.PyTuple

///|
typealias PyFloat = @python.PyFloat

///|
pub struct TimeModule {
  priv time : PyModule
}

///|
pub type! TurtleError {
  LoadTimeModuleError
} derive(Show)

///|
fn new() -> TimeModule!Error {
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
  let lib = match new?() {
    Ok(lib) => lib
    Err(e) => {
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
  let args = PyTuple::new(1)..set(0, PyFloat::from(seconds))
  let _ = f.invoke(args~)
  ()
}
