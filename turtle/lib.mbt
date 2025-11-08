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
