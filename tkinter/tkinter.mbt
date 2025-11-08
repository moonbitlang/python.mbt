// Copyright 2025 International Digital Economy Academy
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

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

///|
typealias @python.(PyModule, PyObject, PyTuple, PyDict, PyString)

///|
pub suberror TkinterError {
  LoadTkinterError
} derive(Show)

///|
pub struct Tkinter {
  priv tkinter : PyModule
}

///|
pub struct Window {
  priv window : PyObject
}

///|
pub struct Label {
  priv label : PyObject
}

///|
fn new() -> Tkinter raise Error {
  guard @python.pyimport("tkinter") is Some(tkinter) else {
    raise LoadTkinterError
  }
  Tkinter::{ tkinter, }
}

///|
let singleton : () -> Tkinter = get_lib()

///|
fn get_lib() -> () -> Tkinter {
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
pub fn Window::new() -> Window {
  let lib = singleton()
  guard lib.tkinter.get_attr("Tk") is Some(PyCallable(createWindow))
  guard (try? createWindow.invoke()).unwrap() is Some(PyClass(window))
  Window::{ window, }
}

///|
pub fn Window::set_title(self : Window, title : String) -> Unit {
  guard self.window.get_attr("title") is Some(PyCallable(setTitle))
  let args = PyTuple::new(1)
  args..set(0, PyString::from(title))
  let _ = try? setTitle.invoke(args~)

}

///|
pub fn Window::mainloop(self : Window) -> Unit {
  guard self.window.get_attr("mainloop") is Some(PyCallable(mainloop))
  let _ = try? mainloop.invoke()

}

///|
pub fn Label::new(window : Window, text : String) -> Label {
  let lib = singleton()
  guard lib.tkinter.get_attr("Label") is Some(PyCallable(createLabel))
  let args = PyTuple::new(1)
  args..set(0, window.window)
  let kwargs = PyDict::new()
  kwargs..set("text", PyString::from(text))
  guard (try? createLabel.invoke(args~, kwargs~)).unwrap()
    is Some(PyClass(label))
  Label::{ label, }
}

///|
pub fn Label::pack(self : Label) -> Unit {
  guard self.label.get_attr("pack") is Some(PyCallable(pack))
  let _ = try? pack.invoke()

}
