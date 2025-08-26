// ========================================
// Tuple
// ========================================

///|
pub struct PyTuple {
  priv obj : PyObject
}

///| Create a PyTuple object.
///
/// **Notes**: Tuple type must know the size of the tuple.
///
/// ## Example:
///
/// ```moonbit
/// let tuple = PyTuple::new(3)
/// tuple
/// ..set(0, PyInteger::from(1))
/// ..set(1, PyFloat::from(2.0))
/// ..set(2, PyString::from("three"));
///
/// inspect(tuple, content="(1, 2.0, \'three\')")
/// ```
pub fn PyTuple::new(size : UInt64) -> PyTuple {
  PyTuple::{ obj: @cpython.pytuple_new(size) |> PyObject::create }
}

///| Create a PyTuple object from a python object.
/// If the python object is not a tuple, it will raise a TypeMisMatchError.
pub fn PyTuple::create(obj : PyObject) -> PyTuple raise PyRuntimeError {
  guard obj.is_tuple() else { raise TypeMisMatchError }
  PyTuple::{ obj, }
}

///|
fn PyTuple::create_unchecked(obj : PyObject) -> PyTuple {
  PyTuple::{ obj, }
}

///| Create a PyTuple object from a python object reference.
/// If the python object is not a tuple, it will raise a TypeMisMatchError.
pub fn PyTuple::create_by_ref(
  obj_ref : @cpython.PyObjectRef
) -> PyTuple raise PyRuntimeError {
  guard @cpython.py_tuple_check(obj_ref) else { raise TypeMisMatchError }
  PyTuple::{ obj: PyObject::create(obj_ref) }
}

///|
fn PyTuple::create_by_ref_unchecked(obj_ref : @cpython.PyObjectRef) -> PyTuple {
  PyTuple::{ obj: PyObject::create(obj_ref) }
}

///|
test {
  ignore(PyTuple::create_by_ref_unchecked)
}

///| Return the size of the tuple.
///
/// ## Example:
///
/// ```moonbit
/// let tuple = PyTuple::new(3)
///
/// assert_eq(tuple.len(), 3);
/// ```
pub fn PyTuple::len(self : PyTuple) -> UInt64 {
  @cpython.pytuple_size(self.obj_ref())
}

///| Get the item at the given index.
///
/// **Notes**: Although python supports negative index, in moonbit, we don't have plan to
/// support it. Code like `tuple.get(-1)` will return `None`.
///
/// ## Example:
///
/// ```moonbit
/// let tuple = PyTuple::new(3)
/// tuple
/// ..set(0, PyInteger::from(1))
/// ..set(1, PyFloat::from(2.0))
/// ..set(2, PyString::from("three"));
///
/// inspect(tuple, content="(1, 2.0, \'three\')")
/// inspect(tuple.get(0).unwrap(), content="PyInteger(1)")
/// inspect(tuple.get(1).unwrap(), content="PyFloat(2.0)")
/// inspect(tuple.get(2).unwrap(), content="PyString(three)")
/// inspect(tuple.get(3), content="None")
/// ```
///
/// The above code is equivalent the following python code:
///
/// ```python
/// tuple = (1, 2.0, "three")
///
/// print(tuple) # Output: (1, 2.0, 'three')
/// print(tuple[0]) # Output: 1
/// print(tuple[1]) # Output: 2.0
/// print(tuple[2]) # Output: three
pub fn PyTuple::get(self : PyTuple, idx : Int) -> PyObjectEnum? {
  when(idx >= 0 && idx.to_uint64() < self.len(), fn() {
    @cpython.pytuple_get_item(self.obj_ref(), idx.to_uint64())
    |> PyObject::create
    |> PyObjectEnum::create
  })
}

///| Get the item at the given index.
///
/// **Notes**: Although python supports negative index, in moonbit, we don't have plan to
/// support it. Code like `tuple[-1]` will return `None`.
///
/// ## Example:
///
/// ```moonbit
/// let tuple = PyTuple::new(3)
/// tuple
/// ..set(0, PyInteger::from(1))
/// ..set(1, PyFloat::from(2.0))
/// ..set(2, PyString::from("three"));
///
/// inspect(tuple[0], content="PyInteger(1)")
/// inspect(tuple[1], content="PyFloat(2.0)")
/// inspect(tuple[2], content="PyString(three)")
/// ```
pub fn PyTuple::op_get(self : PyTuple, idx : Int) -> PyObjectEnum {
  self.get(idx).unwrap()
}

///| Set the item at the given index.
///
/// **Notes**: Although python supports negative index, in moonbit, we don't have plan to
/// support it. Code like `tuple.set(-1, item)` will raise `IndexOutOfBoundError`.
///
/// ## Example:
///
/// ```moonbit
/// let tuple = PyTuple::new(3)
/// tuple
/// ..set(0, PyInteger::from(1))
/// ..set(1, PyFloat::from(2.0))
/// ..set(2, PyString::from("three"));
///
/// inspect(tuple, content="(1, 2.0, \'three\')")
/// ```
pub fn[T : IsPyObject] PyTuple::set(
  self : PyTuple,
  idx : Int,
  item : T
) -> Unit {
  guard idx >= 0 && idx.to_uint64() < self.len()
  let _ = @cpython.pytuple_set_item(
    self.obj_ref(),
    idx.to_uint64(),
    item.obj_ref(),
  )

}

///| Set the item at the given index.
///
/// **Notes**: Although python supports negative index, in moonbit, we don't have plan to
/// support it. Code like `tuple[-1] = item` will raise `IndexOutOfBoundError`.
///
/// ## Example:
///
/// ```moonbit
/// let tuple = PyTuple::new(3)
/// tuple
/// ..set(0, PyInteger::from(1))
/// ..set(1, PyFloat::from(2.0))
/// ..set(2, PyString::from("three"));
///
/// inspect(tuple, content="(1, 2.0, \'three\')")
/// ```
pub fn[T : IsPyObject] PyTuple::op_set(
  self : PyTuple,
  idx : Int,
  item : T
) -> Unit {
  self.set(idx, item)
}

///|
pub fn PyTuple::dump(self : PyTuple) -> Unit {
  PyObject::dump(self.obj)
}

///|
pub fn PyTuple::drop(self : PyTuple) -> Unit {
  self.obj.drop()
}

///|
pub impl IsPyObject for PyTuple with obj(self) -> PyObject {
  self.obj
}

///|
pub impl Show for PyTuple with to_string(self) -> String {
  self.obj.to_string()
}

///|
pub impl Show for PyTuple with output(self : PyTuple, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}
