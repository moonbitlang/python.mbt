///|
typealias PyModule = @python.PyModule

///|
typealias PyObject = @python.PyObject

///|
typealias PyTuple = @python.PyTuple

///|
typealias PyDict = @python.PyDict

///|
typealias PyString = @python.PyString

///|
typealias PyInteger = @python.PyInteger

///|
typealias PyFloat = @python.PyFloat

///|
typealias PyCallable = @python.PyCallable

///|
pub type! TurtleError {
  LoadTurtleError
} derive(Show)

///|
pub struct Turtle {
  priv turtle : PyModule
}

///|
fn new() -> Turtle!Error {
  guard @python.pyimport("turtle") is Some(turtle) else {
    raise LoadTurtleError
  }
  Turtle::{ turtle, }
}

///|
let singleton : () -> Turtle = get_lib()

///|
fn get_lib() -> () -> Turtle {
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
pub fn bgcolor(color : Color) -> Unit {
  let lib = singleton()
  guard lib.turtle.get_attr("bgcolor") is Some(PyCallable(bgcolor))
  let args = PyTuple::new(1)..set(0, PyString::from(color.to_string()))
  let _ = bgcolor.invoke(args~)
  ()
}
