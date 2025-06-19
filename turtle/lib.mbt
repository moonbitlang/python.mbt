///|
typealias @python.(
  PyModule,
  PyObject,
  PyTuple,
  PyDict,
  PyString,
  PyInteger,
  PyFloat,
  PyCallable
)

///|
pub suberror TurtleError {
  LoadTurtleError
} derive(Show)

///|
pub struct Turtle {
  priv turtle : PyModule
}

///|
fn new() -> Turtle raise Error {
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
  let lib = new() catch {
    e => {
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
  let args = PyTuple::new(1)
  args..set(0, PyString::from(color.to_string()))
  let _ = try? bgcolor.invoke(args~)
  ()
}
