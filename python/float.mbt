pub struct PyFloat {
  priv obj: PyObject
}

fn PyFloat::obj(self: PyFloat) -> PyObject {
  self.obj
}

pub fn PyFloat::create_by_ref_unchecked(obj: @cpython.PyObjectRef) -> PyFloat {
  PyFloat::{
    obj: PyObject::create(obj)
  }
}

///| Create a PyFloat from a Double value.
///
/// ## Example
///
/// ```moonbit
/// test "PyFloat::from" {
///   let f = @python.PyFloat::from(3.5);
///   inspect!(f, content="3.5")
/// }
/// ```
pub fn PyFloat::from(value: Double) -> PyFloat {
  PyFloat::{
    obj: @cpython.py_float_from_double(value) |> PyObject::create
  }
}

///| Convert a PyFloat to a Double.
///
/// ## Example
///
/// ```moonbit
/// test "PyFloat::to_double" {
///  let f = @python.PyFloat::from(3.5);
///  assert_eq!(f.to_double(), 3.5);
///  }
/// ```
pub fn PyFloat::to_double(self: PyFloat) -> Double {
  @cpython.py_float_as_double(self.obj_ref())
}

///| Print the PyFloat object direcly.
///
/// Different from use `println`, `dump` means we made python interpreter
/// print the object directly.
///
/// ## Example
///
/// ```moonbit-no-test
///   let f = @python.PyFloat::from(3.5);
///   f.dump()
/// ```
///
/// the code above will print: 3.5
pub fn PyFloat::dump(self: PyFloat) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyFloat::drop(self: PyFloat) -> Unit {
  self.obj.drop()
}

///| Get the type name of the PyFloat object.
///
/// Note: Always return "float" if no error occurs.
///
/// ## Example
///
/// ```moonbit
/// test "PyFloat::type_name" {
///   let f = @python.PyFloat::from(3.5);
///   inspect!(f.type_name(), content="float")
/// }
/// ```
pub impl IsPyObject for PyFloat with type_name(self) {
  self.obj.type_name()
}

pub impl IsPyObject for PyFloat with obj(self) {
  self.obj()
}

pub impl Show for PyFloat with to_string(self) -> String {
  @cpython.py_object_moonbit_repr(self.obj_ref())
}

pub impl Show for PyFloat with output(
  self:PyFloat, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}
