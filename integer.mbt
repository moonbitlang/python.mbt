// ========================================
// PyInteger
// ========================================

///|
pub struct PyInteger {
  priv obj : PyObject
}

///| Create a python integer object from a python object.
/// If 
pub fn PyInteger::create(obj : PyObject) -> PyInteger raise PyRuntimeError {
  guard obj.is_int() else { raise TypeMismatchError }
  PyInteger::{ obj, }
}

///|
pub fn PyInteger::create_unchecked(obj : PyObject) -> PyInteger {
  PyInteger::{ obj, }
}

///|
pub fn PyInteger::create_by_ref(
  obj : @cpython.PyObjectRef,
) -> PyInteger raise PyRuntimeError {
  guard @cpython.py_int_check(obj) else { raise TypeMismatchError }
  PyInteger::{ obj: PyObject::create(obj) }
}

///|
fn PyInteger::create_by_ref_unchecked(obj : @cpython.PyObjectRef) -> PyInteger {
  PyInteger::{ obj: PyObject::create(obj) }
}

///|
test {
  ignore(PyInteger::create_by_ref_unchecked)
}

///| Create a PyInteger from an integer.
///
/// ## Example
///
/// ```moonbit
/// let i = @python.PyInteger::from(42);
/// inspect(i, content="42")
/// ```
pub fn PyInteger::from(value : Int64) -> PyInteger {
  PyInteger::{ obj: PyObject::create(@cpython.py_long_from_long(value)) }
}

///| Convert a PyInteger to an integer.
///
/// ## Example
///
/// ```moonbit
/// let i = @python.PyInteger::from(42);
/// assert_eq(i.to_int64(), 42);
/// ```
pub fn PyInteger::to_int64(self : PyInteger) -> Int64 {
  @cpython.py_long_as_long(self.obj_ref())
}

///| Convert a PyInteger to a double.
///
/// ## Example
///
/// ```moonbit
/// let i = @python.PyInteger::from(42);
/// assert_eq(i.to_double(), 42.0);
/// ```
pub fn PyInteger::to_double(self : PyInteger) -> Double {
  @cpython.py_long_as_double(self.obj_ref())
}

///| Print the PyInteger object directly.
///
/// Different from use `println`, `dump` means we made python interpreter
/// print the object directly.
pub fn PyInteger::dump(self : PyInteger) -> Unit {
  PyObject::dump(self.obj)
}

///|
pub fn PyInteger::drop(self : PyInteger) -> Unit {
  self.obj.drop()
}

///|
pub impl IsPyObject for PyInteger with obj(self) {
  self.obj
}

///|
pub impl Show for PyInteger with to_string(self) -> String {
  self.obj.to_string()
}

///|
pub impl Show for PyInteger with output(self, logger) -> Unit {
  logger.write_string(self.to_string())
}
