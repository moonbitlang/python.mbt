// ========================================
// PyString
// ========================================
pub struct PyString {
  priv obj: PyObject
}

///| Create a PyString from a string
///
/// ## Example
///
/// ```moonbit
/// test "PyString::from" {
///   let s = @python.PyString::from("hello");
///   inspect(s, content="\'hello\'");
/// }
pub fn PyString::from(s: String) -> PyString {
  PyString::{
    obj: PyObject::create(@cpython.py_unicode_from_string(s))
  }
}

pub fn PyString::obj(self: PyString) -> PyObject {
  self.obj
}

///| Print the PyString object direcly.
///
/// Different from use `println`, `dump` means we made python interpreter
/// print the object directly.
///
/// ## Example
///
/// ```moonbit-no-test
///   let s = @python.PyString::from("hello");
///   s.dump()
/// ```
///
/// the code above will print: 'hello'
pub fn PyString::dump(self: PyString) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyString::drop(self: PyString) -> Unit {
  self.obj.drop()
}

///| Get the type name of the PyString object.
///
/// Note: Always return "str" if no error occurs.
///
/// ## Example
///
/// ```moonbit
/// test "PyString::type_name" {
///   let s = @python.PyString::from("hello");
///   inspect!(s.type_name(), content="str")
/// }
/// ```
pub impl IsPyObject for PyString with type_name(self) {
  self.obj.type_name()
}

pub impl IsPyObject for PyString with obj(self) {
  self.obj()
}

pub impl PyAble for PyString with to_pyobject(self) -> PyObject {
  PyObject::create(self.obj_ref())
}

pub impl Show for PyString with to_string(self) {
  PyObject::to_string(self.obj)
}

pub impl Show for PyString with output(
  self:PyString, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

