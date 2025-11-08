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
pub enum PyType {
  PyInteger
  PyFloat
  PyBool
  PyString
  PyTuple
  PyList
  PyDict
  PyModule
  PyCallable
  PyClass
}

///|
pub(all) enum PyObjectEnum {
  PyInteger(PyInteger)
  PyFloat(PyFloat)
  PyBool(PyBool)
  PyString(PyString)
  PyTuple(PyTuple)
  PyList(PyList)
  PyDict(PyDict)
  PyModule(PyModule)
  PyCallable(PyCallable)
  PyClass(PyObject)
} derive(Show)

///|
pub fn PyObjectEnum::create(obj : PyObject) -> PyObjectEnum {
  match obj.type_of() {
    PyInteger => PyInteger(PyInteger::create_unchecked(obj))
    PyFloat => PyFloat(PyFloat::create_unchecked(obj))
    PyBool => PyBool(PyBool::create_unchecked(obj))
    PyString => PyString(PyString::create_unchecked(obj))
    PyTuple => PyTuple(PyTuple::create_unchecked(obj))
    PyList => PyList(PyList::create_unchecked(obj))
    PyDict => PyDict(PyDict::create_unchecked(obj))
    PyModule => PyModule(PyModule::create_unchecked(obj))
    PyCallable => PyCallable(PyCallable::create_unchecked(obj))
    PyClass => PyClass(obj)
  }
}

///|
pub fn PyObjectEnum::dump(self : PyObjectEnum) -> Unit {
  match self {
    PyInteger(obj) => obj.dump()
    PyFloat(obj) => obj.dump()
    PyBool(obj) => obj.dump()
    PyString(obj) => obj.dump()
    PyTuple(obj) => obj.dump()
    PyList(obj) => obj.dump()
    PyDict(obj) => obj.dump()
    PyModule(obj) => obj.dump()
    PyCallable(obj) => obj.dump()
    PyClass(obj) => obj.dump()
  }
}

///|
pub fn PyObjectEnum::create_by_ref(
  obj_ref : @cpython.PyObjectRef,
) -> PyObjectEnum {
  let obj = PyObject::create(obj_ref)
  PyObjectEnum::create(obj)
}
