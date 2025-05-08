
pub struct Screen {
  priv screen : PyObject
}

///|
pub fn Screen::new() -> Screen {
  let lib = singleton()
  guard lib.turtle.get_attr("Screen") is Some(PyCallable(createScreen))
  guard createScreen.invoke() is Some(PyClass(screen))
  Screen::{ screen, }
}

pub fn Screen::setup(self: Screen, width: Double, height: Double) -> Unit {
  guard self.screen.get_attr("setup") is Some(PyCallable(setup))
  let args = PyTuple::new(2)..set(0, PyFloat::from(width))..set(1, PyFloat::from(height))
  let _ = setup.invoke(args~)
}

pub fn Screen::title(self: Screen, text: String) -> Unit {
  guard self.screen.get_attr("title") is Some(PyCallable(title))
  let args = PyTuple::new(1)..set(0, PyString::from(text))
  let _ = title.invoke(args~)
}

pub fn Screen::tracer(self: Screen, n: Int) -> Unit {
  guard self.screen.get_attr("tracer") is Some(PyCallable(tracer))
  let args = PyTuple::new(1)..set(0, PyInteger::from(n.to_int64()))
  let _ = tracer.invoke(args~)
}

pub fn Screen::update(self: Screen) -> Unit {
  guard self.screen.get_attr("update") is Some(PyCallable(update))
  let _ = update.invoke()
}

///|
pub fn Screen::bgcolor(self : Screen, color : Color) -> Unit {
  guard self.screen.get_attr("bgcolor") is Some(PyCallable(bgcolor))
  let args = PyTuple::new(1)..set(0, PyString::from(color.to_string()))
  let _ = bgcolor.invoke(args~)

}
