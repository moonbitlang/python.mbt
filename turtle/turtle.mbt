///|
typealias PyModule = @python.PyModule

///|
typealias PyObject = @python.PyObject

///|
typealias PyTuple = @python.PyTuple

//typealias PyDict = @python.PyDict
///|
typealias PyString = @python.PyString

///|
typealias PyInteger = @python.PyInteger

///|
typealias PyFloat = @python.PyFloat

///|
pub(all) enum Color {
  Red
  Green
  Blue
  Purple
  Orange
  Yellow
  Black
} derive(Show)

///|
pub fn Color::to_pystr(self : Color) -> PyString {
  let s = self.to_string().to_lower()
  PyString::from(s)
}

///|
pub type! TurtleError {
  LoadTurtleError
} derive(Show)

///|
pub struct Turtle {
  priv turtle : PyModule
}

///|
pub struct Pen {
  priv pen : PyObject
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

}

///|
pub fn Pen::home(self : Pen) -> Unit {
  guard self.pen.get_attr("home") is Some(PyCallable(func))
  let _ = func.invoke()

}

///|
pub fn Pen::xcor(self : Pen) -> Double {
  guard self.pen.get_attr("xcor") is Some(PyCallable(func))
  let res = func.invoke()
  guard res is Some(PyFloat(x))
  x.to_double()
}

///|
pub fn Pen::ycor(self : Pen) -> Double {
  guard self.pen.get_attr("ycor") is Some(PyCallable(func))
  let res = func.invoke()
  guard res is Some(PyFloat(y))
  y.to_double()
}

///|
pub fn Pen::position(self : Pen) -> (Double, Double) {
  guard self.pen.get_attr("position") is Some(PyCallable(func))
  let res = func.invoke()
  guard res is Some(PyTuple(tup))
  let x = tup.get(0)
  guard x is Some(PyFloat(x))
  let y = tup.get(1)
  guard y is Some(PyFloat(y))
  (x.to_double(), y.to_double())
}

///|
pub fn Pen::heading(self : Pen) -> Double {
  guard self.pen.get_attr("heading") is Some(PyCallable(func))
  let res = func.invoke()
  guard res is Some(PyFloat(h))
  h.to_double()
}

///|
pub fn Pen::radians(self : Pen) -> Double {
  guard self.pen.get_attr("radians") is Some(PyCallable(func))
  let res = func.invoke()
  guard res is Some(PyFloat(r))
  r.to_double()
}

///|
pub fn Pen::speed(self : Pen, v : Int) -> Unit {
  guard self.pen.get_attr("speed") is Some(PyCallable(func))
  let args = PyTuple::new(1)..set(0, PyInteger::from(v.to_int64()))
  let _ = func.invoke(args~)

}

///|
pub fn Pen::new() -> Pen {
  let lib = singleton()
  guard lib.turtle.get_attr("Pen") is Some(PyCallable(createPen))
  guard createPen.invoke() is Some(PyClass(pen))
  Pen::{ pen, }
}

///|
pub fn Pen::pencolor(self : Pen, color : Color) -> Unit {
  guard self.pen.get_attr("pencolor") is Some(PyCallable(func))
  let args = PyTuple::new(1)..set(0, PyString::from(color.to_string()))
  let _ = func.invoke(args~)

}

///|
pub fn Pen::up(self : Pen) -> Unit {
  guard self.pen.get_attr("penup") is Some(PyCallable(func))
  let _ = func.invoke()

}

///|
pub fn Pen::down(self : Pen) -> Unit {
  guard self.pen.get_attr("pendown") is Some(PyCallable(func))
  let _ = func.invoke()

}

///|
pub fn Pen::width(self : Pen, width : Double) -> Unit {
  guard self.pen.get_attr("width") is Some(PyCallable(func))
  let args = PyTuple::new(1)..set(0, PyFloat::from(width))
  let _ = func.invoke(args~)

}

///|
pub fn Pen::forward(self : Pen, distance : Double) -> Unit {
  guard self.pen.get_attr("forward") is Some(PyCallable(func))
  let args = PyTuple::new(1)..set(0, PyFloat::from(distance))
  let _ = func.invoke(args~)

}

///|
pub fn Pen::backward(self : Pen, distance : Double) -> Unit {
  guard self.pen.get_attr("backward") is Some(PyCallable(func))
  let args = PyTuple::new(1)..set(0, PyFloat::from(distance))
  let _ = func.invoke(args~)

}

///|
pub fn Pen::left(self : Pen, angle : Double) -> Unit {
  guard self.pen.get_attr("left") is Some(PyCallable(func))
  let args = PyTuple::new(1)..set(0, PyFloat::from(angle))
  let _ = func.invoke(args~)

}

///|
pub fn Pen::right(self : Pen, angle : Double) -> Unit {
  guard self.pen.get_attr("right") is Some(PyCallable(func))
  let args = PyTuple::new(1)..set(0, PyFloat::from(angle))
  let _ = func.invoke(args~)

}
