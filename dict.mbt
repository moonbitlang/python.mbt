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
// Dict
// ========================================

///|
pub struct PyDict {
  priv obj : PyObject
}

///|
/// Create a python dict object.
/// If the python object is not a dict, it will raise a TypeMismatchError.
pub fn PyDict::create(obj : PyObject) -> PyDict raise PyRuntimeError {
  guard obj.is_dict() else { raise TypeMismatchError }
  PyDict::{ obj, }
}

///|
fn PyDict::create_unchecked(obj : PyObject) -> PyDict {
  PyDict::{ obj, }
}

///|
/// Create a python dict object from a python object reference.
/// If the python object is not a dict, it will raise a TypeMismatchError.
pub fn PyDict::create_by_ref(
  obj : @cpython.PyObjectRef,
) -> PyDict raise PyRuntimeError {
  guard @cpython.py_dict_check(obj) else { raise TypeMismatchError }
  PyDict::{ obj: PyObject::create(obj) }
}

///|
/// Creates a new python dict object.
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyBool::from(true));
///
/// inspect(dict, content="{\'one\': 1, \'two\': 2.0, \'three\': True}")
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// d = { 'one': 1, 'two': 2.0, 'three': True }
/// 
/// print(d) # Output: {'one': 1, 'two': 2.0, 'three': True}
/// ```
pub fn PyDict::new() -> PyDict {
  PyDict::{ obj: PyObject::create(@cpython.py_dict_new()) }
}

///|
/// Return the length of the dict.
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyString::from("three"));
///
/// assert_eq(dict.len(), 3);
/// ```
pub fn PyDict::len(self : PyDict) -> Int {
  @cpython.py_dict_size(self.obj_ref()).to_int()
}

///|
/// Return the elements of the dict by its key.
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyBool::from(true));
///
/// inspect(dict.get("one").unwrap(), content="PyInteger(1)")
/// inspect(dict.get("two"), content="Some(PyFloat(2.0))")
/// inspect(dict.get("four"), content="None")
/// ```
pub fn PyDict::get(self : PyDict, key : String) -> PyObjectEnum? {
  let dict = self.obj_ref()
  let obj_ref = @cpython.py_dict_get_item_string(dict, key)
  when(not(obj_ref.is_null()), fn() { PyObjectEnum::create_by_ref(obj_ref) })
}

///|
/// Return the elements of the dict by its key, when the key is not string.
pub fn PyDict::getByObj(self : PyDict, key : PyObject) -> PyObjectEnum? {
  let dict = self.obj_ref()
  let obj_ref = @cpython.py_dict_get_item(dict, key.obj_ref())
  when(not(obj_ref.is_null()), fn() { PyObjectEnum::create_by_ref(obj_ref) })
}

///|
/// Return the elements of the dict by its key.
///
/// **Note**: Will panic if the key is not found.
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyBool::from(true));
///
/// inspect(dict["one"], content="PyInteger(1)")
/// inspect(dict["two"], content="PyFloat(2.0)")
/// inspect(dict["three"], content="PyBool(True)")
/// ```
pub fn PyDict::op_get(self : PyDict, key : String) -> PyObjectEnum {
  self.get(key).unwrap()
}

///|
/// Set the elements of the dict by its key (String).
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyBool::from(true));
/// 
/// inspect(dict, content="{\'one\': 1, \'two\': 2.0, \'three\': True}")
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// d = dict()
/// d['one'] = 1
/// d['two'] = 2.0
/// d['three'] = True
/// ```
pub fn[V : IsPyObject] PyDict::set(
  self : PyDict,
  key : String,
  val : V,
) -> Unit {
  let dict = self.obj_ref()
  let val = val.obj_ref()
  let _ = @cpython.py_dict_set_item_string(dict, key, val)

}

///|
/// Set the elements of the dict by its key. (Object)
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..setByObj(PyInteger::from(1), PyInteger::from(1))
/// ..setByObj(PyInteger::from(2), PyInteger::from(4))
/// ..setByObj(PyInteger::from(3), PyInteger::from(9))
///
/// inspect(dict, content="{1: 1, 2: 4, 3: 9}")
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// d = dict()
/// d[1] = 1
/// d[2] = 4
/// d[3] = 9
/// 
/// print(d) # Output: {1: 1, 2: 4, 3: 9}
/// ```
pub fn[K : IsPyObject, V : IsPyObject] PyDict::setByObj(
  self : PyDict,
  key : K,
  val : V,
) -> Unit raise PyRuntimeError {
  let dict = self.obj_ref()
  @cpython.py_err_clear()
  let _ = @cpython.py_dict_set_item(dict, key.obj_ref(), val.obj_ref())
  let e = @cpython.py_err_occurred()
  if not(e.is_null()) {
    @cpython.py_err_clear()
    raise KeyIsUnHashableError
  }
}

///|
/// Set the elements of the dict by its key (String).
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
///
/// dict["one"] = PyInteger::from(1);
/// dict["two"] = PyFloat::from(2.0);
/// dict["three"] = PyBool::from(true);
/// 
/// inspect(dict, content="{\'one\': 1, \'two\': 2.0, \'three\': True}")
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// d = dict()
/// d['one'] = 1
/// d['two'] = 2.0
/// d['three'] = True
/// ```
pub fn[V : IsPyObject] PyDict::op_set(
  self : PyDict,
  key : String,
  val : V,
) -> Unit {
  self.set(key, val)
}

///|
/// Check if the dict contains the key. Note that the key is a string.
/// If the key is not string, use `containsObj` instead.
pub fn PyDict::contains(self : PyDict, key : String) -> Bool {
  let dict = self.obj_ref()
  @cpython.py_dict_contains(dict, PyString::from(key).obj_ref())
}

///|
/// Check if the dict contains the key.
pub fn PyDict::containsObj(self : PyDict, key : PyObject) -> Bool {
  let dict = self.obj_ref()
  @cpython.py_dict_contains(dict, key.obj_ref())
}

///|
/// Get the keys of the dict.
///
/// **Notes**: It is slight different from the python dict.keys() method.
/// In python, dict.keys() returns a view object that displays a list of all the keys.
/// While here in moonbit, keys() returns a list of all the keys.
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyBool::from(true));
///
/// inspect(dict.keys(), content="[\'one\', \'two\', \'three\']")
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// d = { 'one': 1, 'two': 2.0, 'three': True }
/// dict_keys = d.keys()
/// print(dict_keys) # Output: dict_keys(['one', 'two', 'three'])
/// ```
pub fn PyDict::keys(self : PyDict) -> PyList {
  PyList::create_by_ref_unchecked(@cpython.py_dict_keys(self.obj_ref()))
}

///|
/// Get the values of the dict.
///
/// **Notes**: It is slight different from the python dict.values() method.
/// In python, dict.values() returns a view object that displays a list of all the values.
/// While here in moonbit, values() returns a list of all the values.
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyBool::from(true));
///
/// inspect(dict.values(), content="[1, 2.0, True]")
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// d = { 'one': 1, 'two': 2.0, 'three': True }
/// dict_values = d.values()
/// print(dict_values) # Output: dict_values([1, 2.0, True])
/// ```
pub fn PyDict::values(self : PyDict) -> PyList {
  PyList::create_by_ref_unchecked(@cpython.py_dict_values(self.obj_ref()))
}

///|
/// Get the items of the dict.
///
/// **Notes**: It is slight different from the python dict.items() method.
/// In python, dict.items() returns a view object that displays a list of all the items.
/// While here in moonbit, items() returns a list of all the items.
///
/// ## Example
///
/// ```moonbit
/// let dict = PyDict::new()
/// dict
/// ..set("one", PyInteger::from(1))
/// ..set("two", PyFloat::from(2.0))
/// ..set("three", PyBool::from(true));
///
/// inspect(dict.items(), content="[('one', 1), ('two', 2.0), ('three', True)]")
/// ```
pub fn PyDict::items(self : PyDict) -> PyList {
  PyList::create_by_ref_unchecked(@cpython.py_dict_items(self.obj_ref()))
}

///|
/// Let python interpret print the dict directly.
///
/// **Note**: This is different from `println(dict)` and `dict.dump()`.
/// although they always print the same content.
pub fn PyDict::dump(self : PyDict) -> Unit {
  PyObject::dump(self.obj)
}

///|
pub fn PyDict::drop(self : PyDict) -> Unit {
  self.obj.drop()
}

///|
pub impl IsPyObject for PyDict with obj(self) {
  self.obj
}

///|
pub impl Show for PyDict with to_string(self) -> String {
  self.obj.to_string()
}

///|
pub impl Show for PyDict with output(self : PyDict, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}
