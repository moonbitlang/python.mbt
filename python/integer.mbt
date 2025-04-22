// ========================================
// PyInteger
// ========================================
pub struct PyInteger {
  priv obj: PyObject
}

fn PyInteger::obj(self: PyInteger) -> PyObject {
  self.obj
}

pub fn PyInteger::create(obj: PyObject) -> PyInteger!PyRuntimeError {
  guard obj.is_int() else {
    raise TypeMisMatchError
  }

  PyInteger::{
    obj: obj
  }
}

pub fn PyInteger::create_unchecked(obj: PyObject) -> PyInteger {
  PyInteger::{
    obj: obj
  }
}

pub fn PyInteger::create_by_ref_unchecked(obj: @cpython.PyObjectRef) -> PyInteger {
  PyInteger::{
    obj: PyObject::create(obj)
  }
}

///| Create a PyInteger from an integer.
///
/// ## Example
///
/// ```moonbit
/// test "PyInteger::from" {
///   let i = @python.PyInteger::from(42);
///   inspect!(i, content="42")
/// }
/// ```
pub fn PyInteger::from(value: Int64) -> PyInteger {
  PyInteger::{
    obj: PyObject::create(@cpython.py_long_from_long(value))
  }
}

///| Convert a PyInteger to an integer.
///
/// ## Example
///
/// ```moonbit
/// test "PyInteger::to_int64" {
///   let i = @python.PyInteger::from(42);
///   assert_eq!(i.to_int64(), 42);
/// }
/// ```
pub fn PyInteger::to_int64(self: PyInteger) -> Int64 {
  @cpython.py_long_as_long(self.obj_ref())
}

///| Convert a PyInteger to a double.
///
/// ## Example
///
/// ```moonbit
/// test "PyInteger::to_double" {
///   let i = @python.PyInteger::from(42);
///   assert_eq!(i.to_double(), 42.0);
///   }
///  /// ```
pub fn PyInteger::to_double(self: PyInteger) -> Double {
  @cpython.py_long_as_double(self.obj_ref())
}

///| Print the PyInteger object direcly.
///
/// Different from use `println`, `dump` means we made python interpreter
/// print the object directly.
///
/// ## Example
///
/// ```moonbit-no-test
///   let i = @python.PyInteger::from(42);
///   i.dump()
/// ```
///
/// the code above will print: 42
pub fn PyInteger::dump(self: PyInteger) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyInteger::drop(self: PyInteger) -> Unit {
  self.obj.drop()
}

// ======== Implement Traits ==========

///| Get the type name of the PyInteger object.
///
/// Note: Always return "int" if no error occurs.
///
/// ## Example
///
/// ```moonbit
/// test "PyInteger::type_name" {
///   let i = @python.PyInteger::from(42);
///   inspect!(i.type_name(), content="int")
/// }
/// ```
pub impl IsPyObject for PyInteger with type_name(self) {
  self.obj.type_name()
}

///|
pub impl IsPyObject for PyInteger with obj(self) {
  self.obj()
}

pub impl Show for PyInteger with to_string(self) -> String {
  @cpython.py_object_moonbit_repr(self.obj_ref())
}

pub impl Show for PyInteger with output(self, logger) -> Unit {
  logger.write_string(self.to_string())
}
