// Example
//typealias Window = @tkinter.Window
//typealias Label = @tkinter.Label
//
//fn main {
//  let window = Window::new()
//  window.set_title("Hello, World!")
//
//  let label = Label::new(window, "Hello, World!")
//  label.pack()
//
//  window.mainloop()
//}

typealias PyModule = @python.PyModule
typealias PyObject = @python.PyObject
typealias PyTuple = @python.PyTuple
typealias PyDict = @python.PyDict
typealias PyString = @python.PyString

pub type! TkinterError {
  LoadTkinterError
} derive(Show)

pub struct Tkinter {
  priv tkinter: PyModule
}

pub struct Window {
  priv window: PyObject
}

pub struct Label {
  priv label: PyObject
}

fn new() -> Tkinter!Error {
  guard @python.pyimport("tkinter") is Some(tkinter) else {
    raise LoadTkinterError
  }
  Tkinter::{
    tkinter
  }
}

let singleton : () -> Tkinter = get_lib()

fn get_lib() -> () -> Tkinter {
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

pub fn Window::new() -> Window {
  let lib = singleton()
  guard lib.tkinter.get_attr("Tk") is Some(PyCallable(createWindow))
  let args0 = PyTuple::new(0)
  guard createWindow.invoke(args0) is Some(PyClass(window))
  Window::{ window }
}

pub fn Window::set_title(self: Window, title: String) -> Unit {
  guard self.window.get_attr("title") is Some(PyCallable(setTitle))
  let args = PyTuple::new(1)
  args.set?(0, PyString::from(title)).unwrap()
  let _ = setTitle.invoke(args)
}

pub fn Window::mainloop(self: Window) -> Unit {
  guard self.window.get_attr("mainloop") is Some(PyCallable(mainloop))
  let args0 = PyTuple::new(0)
  let _ = mainloop.invoke(args0)
}

pub fn Label::new(window:Window, text: String) -> Label {
  let lib = singleton()
  guard lib.tkinter.get_attr("Label") is Some(PyCallable(createLabel))
  let args = PyTuple::new(1)
  args.set?(0, window.window).unwrap()
  let kwargs = PyDict::new() .. set("text", PyString::from(text))
  guard createLabel.invoke(args, kwargs=kwargs) is Some(PyClass(label))
  Label::{ label }
}

pub fn Label::pack(self:Label) -> Unit {
  guard self.label.get_attr("pack") is Some(PyCallable(pack))
  let args0 = PyTuple::new(0)
  let _ = pack.invoke(args0)
}
