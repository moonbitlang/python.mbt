// ========================================
// PyString
// ========================================

///|
pub struct PyString {
  priv obj : PyObject
}

///| Create a python string from a python object.
/// If the python object is not a string, it will raise a TypeMismatchError.
pub fn PyString::create(obj : PyObject) -> PyString raise PyRuntimeError {
  guard obj.is_string() else { raise TypeMismatchError }
  PyString::{ obj, }
}

///|
fn PyString::create_unchecked(obj : PyObject) -> PyString {
  PyString::{ obj, }
}

///| Create a python string from a python object reference.
///If the python object is not a string, it will raise a TypeMismatchError.
pub fn PyString::create_by_ref(
  obj_ref : @cpython.PyObjectRef,
) -> PyString raise PyRuntimeError {
  guard @cpython.py_string_check(obj_ref) else { raise TypeMismatchError }
  PyString::{ obj: PyObject::create(obj_ref) }
}

///|
fn PyString::create_by_ref_unchecked(
  obj_ref : @cpython.PyObjectRef,
) -> PyString {
  PyString::{ obj: PyObject::create(obj_ref) }
}

///|
test {
  ignore(PyString::create_by_ref_unchecked)
}

///| Create a PyString from a string
///
/// ## Example
///
/// ```moonbit
/// let s = @python.PyString::from("hello");
/// inspect(s, content="hello");
/// ```
pub fn PyString::from(s : String) -> PyString {
  PyString::{
    obj: PyObject::create(@cpython.py_unicode_from_moonbit_string(s)),
  }
}

///| Print the PyString object direcly.
///
/// Different from use `println`, `dump` means we made python interpreter
/// print the object directly.
pub fn PyString::dump(self : PyString) -> Unit {
  PyObject::dump(self.obj)
}

///|
pub fn PyString::drop(self : PyString) -> Unit {
  self.obj.drop()
}

///|
pub impl IsPyObject for PyString with obj(self) {
  self.obj
}

///|
pub impl Show for PyString with to_string(self) {
  self.obj.to_string()
}

///|
pub impl Show for PyString with output(self : PyString, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}
