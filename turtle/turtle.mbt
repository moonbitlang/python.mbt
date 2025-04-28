typealias PyModule = @python.PyModule
typealias PyObject = @python.PyObject
typealias PyTuple = @python.PyTuple
//typealias PyDict = @python.PyDict
typealias PyString = @python.PyString
//typealias PyInteger = @python.PyInteger
typealias PyFloat = @python.PyFloat

pub(all) enum Color {
  Red
  Green
  Blue
  Purple
  Orange
  Yellow
  Black
}

pub impl Show for Color with to_string(self) {
  match self {
    Red => "red"
    Green => "green"
    Blue => "blue"
    Purple => "purple"
    Orange => "orange"
    Yellow => "yellow"
    Black => "black"
  }
}

pub impl Show for Color with output(self, logger) {
  logger.write_string(self.to_string())
}

pub type! TurtleError {
  LoadTurtleError
} derive(Show)

pub struct Turtle {
  priv turtle: PyModule
}

pub struct Pen {
  priv pen: PyObject
}

fn new() -> Turtle!Error {
  guard @python.pyimport("turtle") is Some(turtle) else {
    raise LoadTurtleError
  }
  Turtle::{
    turtle
  }
}

let singleton : () -> Turtle = get_lib()

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

pub fn bgcolor(color: Color) -> Unit {
  let lib = singleton()
  guard lib.turtle.get_attr("bgcolor") is Some(PyCallable(bgcolor))
  let args0 = PyTuple::new(1) .. set(0, PyString::from(color.to_string()))
  let _ = bgcolor.invoke(args0)
}

pub fn Pen::new() -> Pen {
  let lib = singleton()
  guard lib.turtle.get_attr("Pen") is Some(PyCallable(createPen))
  let args0 = PyTuple::new(0)
  guard createPen.invoke(args0) is Some(PyClass(pen))
  Pen::{ pen }
}

pub fn Pen::pencolor(self: Pen, color: Color) -> Unit {
  guard self.pen.get_attr("pencolor") is Some(PyCallable(func))
  let args0 = PyTuple::new(1)
      ..set(0, PyString::from(color.to_string()))
  let _ = func.invoke(args0)
}

pub fn Pen::width(self: Pen, width: Double) -> Unit {
  guard self.pen.get_attr("width") is Some(PyCallable(func))
  let args0 = PyTuple::new(1)
            ..set(0, PyFloat::from(width))
  let _ = func.invoke(args0)
}

pub fn Pen::forward(self: Pen, distance: Double) -> Unit {
  guard self.pen.get_attr("forward") is Some(PyCallable(func))
  let args0 = PyTuple::new(1)
            ..set(0, PyFloat::from(distance))

  let _ = func.invoke(args0)
}

pub fn Pen::left(self: Pen, angle: Double) -> Unit {
  guard self.pen.get_attr("left") is Some(PyCallable(func))
  let args0 = PyTuple::new(1)
            ..set(0, PyFloat::from(angle))
  let _ = func.invoke(args0)
}
