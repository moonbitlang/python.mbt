typealias PyModule = @python.PyModule
typealias PyString = @python.PyString
typealias PyInteger = @python.PyInteger
typealias PyTuple = @python.PyTuple
typealias PyDict = @python.PyDict
typealias PyList = @python.PyList
typealias PyObject = @python.PyObject

pub type! PyQt5Error {
  LoadPyQt5Error
  LoadWidgetsError
  FuncNotFoundError(String)
} derive(Show);

struct PyQt5 {
  qt: PyModule
  widgets: PyModule
}

struct QApplication {
  obj: PyObject
}

struct QMainWindow {
  obj: PyObject
}

struct QWidget {
  obj: PyObject
}

struct QLabel {
  obj: PyObject
}

pub fn new() -> PyQt5!Error {
  guard @python.pyimport("PyQt5") is Some(qt) else {
    raise LoadPyQt5Error
  }

  guard @python.pyimport("PyQt5.QtWidgets") is Some(widgets) else {
    raise LoadWidgetsError
  }

  PyQt5::{
    qt,
    widgets
  }
}

let singleton : () -> PyQt5 = get_lib()

fn get_lib() -> () -> PyQt5 {
  @python.init_py()
 
  let mlib = match new?() {
    Ok(mlib) => {
      println("PyQt5 loaded")
      mlib
    }
    Err(e) => {
      println(e)
      panic()
    }
  }

  fn () {mlib}
}

pub fn QApplication::new() -> QApplication {
  let lib = singleton()
  guard lib.widgets.get_func("QApplication") is Some(func)
  let args = PyTuple::new(1) .. set(0, PyList::new())

  let obj = func.invoke(args)

  QApplication::{ obj }
}

pub fn QApplication::exec(self: QApplication) -> Int64 {
  guard self.obj.get_method("exec") is Some(func)
  let args = PyTuple::new(1) .. set(0, self.obj)

  let code = func.invoke(args)
  PyInteger::create(code).to_int64()
}

pub fn QMainWindow::new() -> QMainWindow {
  let lib = singleton()
  guard lib.widgets.get_func("QMainWindow") is Some(func)
  let args = PyTuple::new(0)

  let obj = func.invoke(args)
  QMainWindow::{ obj }
}

pub fn QWidget::new() -> QWidget {
  let lib = singleton()
  guard lib.widgets.get_func("QWidget") is Some(func)
  let args = PyTuple::new(0)

  let obj = func.invoke(args)
  QWidget::{ obj }
}

pub fn QLabel::new(text: String, widget: QMainWindow) -> QLabel {
  let lib = singleton()
  guard lib.widgets.get_func("QLabel") is Some(func)
  let args = PyTuple::new(2) 
             .. set(0, PyString::from(text))
             .. set(1, widget.obj)

  let obj = func.invoke(args)
  QLabel::{ obj }
}

pub fn QLabel::moveTo(self: QLabel, x: Int64, y: Int64) -> Unit {
  guard self.obj.get_method("move") is Some(func)
  let args = PyTuple::new(3) 
             .. set(0, self.obj)
             .. set(1, PyInteger::new(x))
             .. set(2, PyInteger::new(y))

  let _ = func.invoke(args)
}

pub fn QLabel::setStyleSheet(self: QLabel, style: String) -> Unit {
  guard self.obj.get_method("setStyleSheet") is Some(func)
  let args = PyTuple::new(2) 
             .. set(0, self.obj)
             .. set(1, PyString::from(style))

  let _ = func.invoke(args)
}

pub fn QMainWindow::setWindowTitle(self: QMainWindow, title: String) -> Unit {
  guard self.obj.get_method("setWindowTitle") is Some(func)

  let args = PyTuple::new(2) 
             .. set(0, self.obj)
             .. set(1, PyString::from(title))

  let _ = func.invoke(args)
}

pub fn QMainWindow::setGeometry(self: QMainWindow, x: Int64, y: Int64, w: Int64, h: Int64) -> Unit {
  guard self.obj.get_method("setGeometry") is Some(func)
  let args = PyTuple::new(5) 
             .. set(0, self.obj)
             .. set(1, PyInteger::new(x))
             .. set(2, PyInteger::new(y))
             .. set(3, PyInteger::new(w))
             .. set(4, PyInteger::new(h))

  let _ = func.invoke(args)
}

pub fn QMainWindow::show(self: QMainWindow) -> Unit {
  guard self.obj.get_method("show") is Some(func)
  let args = PyTuple::new(1) .. set(0, self.obj)

  let _ = func.invoke(args)
}
