///|
pub struct PyFloat {
  priv obj : PyObject
}

///| Create a python float object from a python object.
/// If the python object is not a float, it will raise a TypeMisMatchError.
pub fn PyFloat::create(obj : PyObject) -> PyFloat raise PyRuntimeError {
  guard obj.is_float() else { raise TypeMisMatchError }
  PyFloat::{ obj, }
}

///|
fn PyFloat::create_unchecked(obj : PyObject) -> PyFloat {
  PyFloat::{ obj, }
}

///| Ceate a python float object from a python object reference.
/// If the python object is not a float, it will raise a TypeMisMatchError.
pub fn PyFloat::create_by_ref(
  obj : @cpython.PyObjectRef
) -> PyFloat raise PyRuntimeError {
  guard @cpython.py_float_check(obj) else { raise TypeMisMatchError }
  PyFloat::{ obj: PyObject::create(obj) }
}

///|
fn PyFloat::create_by_ref_unchecked(obj : @cpython.PyObjectRef) -> PyFloat {
  PyFloat::{ obj: PyObject::create(obj) }
}

///|
test {
  ignore(PyFloat::create_by_ref_unchecked)
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
pub fn PyFloat::from(value : Double) -> PyFloat {
  PyFloat::{ obj: @cpython.py_float_from_double(value) |> PyObject::create }
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
pub fn PyFloat::to_double(self : PyFloat) -> Double {
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
pub fn PyFloat::dump(self : PyFloat) -> Unit {
  PyObject::dump(self.obj)
}

///|
pub fn PyFloat::drop(self : PyFloat) -> Unit {
  self.obj.drop()
}

///|
pub impl IsPyObject for PyFloat with obj(self) {
  self.obj
}

///|
pub impl Show for PyFloat with to_string(self) -> String {
  @cpython.py_object_moonbit_repr(self.obj_ref())
}

///|
pub impl Show for PyFloat with output(self : PyFloat, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}
