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

// ========================================
// Function
// ========================================

///|
pub struct PyCallable {
  priv obj : PyObject
}

///|
/// Create a python callable object from a PyObject.
/// If the object is not callable, a TypeMisMatchError is raised.
pub fn PyCallable::create(obj : PyObject) -> PyCallable raise PyRuntimeError {
  guard obj.is_callable() else { raise TypeMisMatchError }
  PyCallable::{ obj, }
}

///|
fn PyCallable::create_unchecked(obj : PyObject) -> PyCallable {
  PyCallable::{ obj, }
}

///|
/// Create a python callable object from a PyObjectRef.
/// If the object is not callable, a TypeMisMatchError is raised.
pub fn PyCallable::create_by_ref(
  obj : @cpython.PyObjectRef,
) -> PyCallable raise PyRuntimeError {
  guard @cpython.py_callable_check(obj) else { raise TypeMisMatchError }
  PyCallable::{ obj: PyObject::create(obj) }
}

///|
fn PyCallable::create_by_ref_unchecked(
  obj : @cpython.PyObjectRef,
) -> PyCallable {
  PyCallable::{ obj: PyObject::create(obj) }
}

///|
/// TODO: eliminate this test.
test {
  ignore(PyCallable::create_by_ref_unchecked)
}

///|
pub fn PyCallable::dump(self : PyCallable) -> Unit {
  self.obj.dump()
}

///|
pub fn PyCallable::invoke(
  self : PyCallable,
  args? : PyTuple = PyTuple::new(0),
  kwargs? : PyDict = PyDict::new(),
  print_err? : Bool = false,
) -> PyObjectEnum? raise PyRuntimeError {
  let obj_ref = if kwargs.len() > 0 {
    @cpython.py_object_call(self.obj_ref(), args.obj_ref(), kwargs.obj_ref())
  } else {
    @cpython.py_object_call_object(self.obj_ref(), args.obj_ref())
  }
  if obj_ref.is_null() {
    let e = @cpython.py_err_occurred()
    if not(e.is_null()) {
      if print_err {
        @cpython.py_err_print()
      }
      @cpython.py_err_clear()
      raise InVokeError
    }
  }
  unless(@cpython.py_none_check(obj_ref), fn() {
    let obj = PyObject::create(obj_ref)
    PyObjectEnum::create(obj)
  })
}

///|
pub impl IsPyObject for PyCallable with obj(self) -> PyObject {
  self.obj
}

///|
pub impl Show for PyCallable with to_string(self) {
  self.obj.to_string()
}

///|
pub impl Show for PyCallable with output(self, logger) {
  logger.write_string(self.to_string())
}
