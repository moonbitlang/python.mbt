///|
pub struct Pen {
  priv pen : PyObject
  methods: Map[String,PyCallable]
}

fn Pen::get_method(self : Pen, name : String) -> PyCallable? {
  match self.methods.get(name) {
    Some(m) => Some(m)
    None => match self.pen.get_attr(name) {
      Some(PyCallable(m)) => Some(m)
      _ => None
    }
  }
}

///|
pub fn Pen::new() -> Pen {
  let lib = singleton()
  guard lib.turtle.get_attr("Pen") is Some(PyCallable(createPen))
  guard createPen.invoke() is Some(PyClass(pen))
  Pen::{ pen, methods:Map::new()}
}

///|
pub fn Pen::home(self : Pen) -> Unit {
  guard self.get_method("home") is Some(func)
  let _ = func.invoke()
  ()
}

///|
pub fn Pen::pensize(self : Pen, size : Double) -> Unit {
  guard self.get_method("pensize") is Some(func)
  let args = PyTuple::new(1)..set(0, PyFloat::from(size))
  let _ = func.invoke(args~)

}

///|
pub fn Pen::xcor(self : Pen) -> Double {
  guard self.get_method("xcor") is Some(func)
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

pub fn Pen::goto(self : Pen, x : Double, y : Double) -> Unit {
  guard self.pen.get_attr("goto") is Some(PyCallable(func))
  let args = PyTuple::new(2)..set(0, PyFloat::from(x))..set(1, PyFloat::from(y))
  let _ = func.invoke(args~)

}

pub fn Pen::hide(self : Pen) -> Unit {
  guard self.pen.get_attr("hideturtle") is Some(PyCallable(func))
  let _ = func.invoke()

}

pub fn Pen::penup(self : Pen) -> Unit {
  guard self.pen.get_attr("penup") is Some(PyCallable(func))
  let _ = func.invoke()

}

pub fn Pen::pendown(self : Pen) -> Unit {
  guard self.pen.get_attr("pendown") is Some(PyCallable(func))
  let _ = func.invoke()

}

pub fn Pen::dot(self : Pen, size : Double, color : Color) -> Unit {
  guard self.get_method("dot") is Some(func)
  let args = PyTuple::new(2)..set(0, PyFloat::from(size))..set(1, PyString::from(color.to_string()))
  guard func.invoke(args~) is Some(PyClass(r))
  r.drop()
  ()
}

pub fn Pen::clear(self : Pen) -> Unit {
  guard self.pen.get_attr("clear") is Some(PyCallable(func))
  let _ = func.invoke()

}
