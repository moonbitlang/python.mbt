// ========================================
// PyBool
// ========================================
pub struct PyBool {
   obj: PyObject
}

pub fn PyBool::create(obj: PyObject) -> PyBool!PyRuntimeError {
  guard obj.is_bool() else {
    raise TypeMisMatchError
  }

  PyBool::{ obj }
}

pub fn PyBool::create_unchecked(obj: PyObject) -> PyBool {
  PyBool::{ obj }
}

pub fn PyBool::create_by_ref(obj_ref: @cpython.PyObjectRef) -> PyBool!PyRuntimeError {
  guard @cpython.py_object_is_bool(obj_ref) else {
    raise TypeMisMatchError
  }

  PyBool::{ obj:PyObject::create(obj_ref) }
} 

pub fn PyBool::create_by_ref_unchecked(obj_ref: @cpython.PyObjectRef) -> PyBool {
  PyBool::{ obj:PyObject::create(obj_ref) }
}

///| Create a python boolean object from moonbit bool.
///
/// ## Example
///
/// ```moonbit
/// test "PyBool::from" {
///   let t = PyBool::from(true);
///
///   inspect!(t, content="True")
/// }
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// t = True
/// 
/// print(t) # Output: True
/// ```
pub fn PyBool::from(value: Bool) -> PyBool {
  let value = value.to_int64()

  let obj_ref = @cpython.py_bool_from_long(value)
  PyBool::create_by_ref_unchecked(obj_ref)
}

///| Return `true` if it is true, using python interpreter.
///
/// ## Example
///
/// ```moonbit
/// test "PyBool::is_true" {
///   let t = PyBool::from(true);
///   let f = PyBool::from(false);
///
///   assert_true!(t.is_true());
///   assert_false!(f.is_true());
/// }
/// ```
pub fn PyBool::is_true(self: PyBool) -> Bool {
  let obj = self.obj_ref()
  @cpython.py_object_is_true(obj)
}

///| Return `true` if it is false, using python interpreter.
///
/// ## Example
///
/// ```moonbit
/// test "PyBool::is_false" {
///   let t = PyBool::from(true);
///   let f = PyBool::from(false);
///
///   assert_false!(t.is_false());
///   assert_true!(f.is_false());
/// }
/// ```
pub fn PyBool::is_false(self: PyBool) -> Bool {
  self.is_true() |> not
}

///| Return the reverse of the boolean value.
///
//// ## Example
///
/// ```moonbit
/// test "PyBool::not" {
///   let t = PyBool::from(true);
///   let f = t.not();
///
///   assert_true!(f.is_false());
/// }
/// ```
pub fn PyBool::not(self: PyBool) -> PyBool {
  if self.is_true() {
    return PyBool::from(false)
  } else {
    return PyBool::from(true)
  }
}

///| Return the type name of the object.
///
/// ## Example
///
/// ```moonbit
/// test "PyBool::type_name" {
///   let t = PyBool::from(true);
///
///   inspect!(t.type_name(), content="bool")
/// }
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// t = True
/// print(type(t)) # Output: <class 'bool'>
/// ```
pub impl IsPyObject for PyBool with type_name(self) {
  self.obj.type_name()
}

pub impl IsPyObject for PyBool with obj(self) {
  self.obj
}

pub impl IsPyObject for PyBool with obj_ref(self) {
  self.obj.obj_ref()
}

pub impl Show for PyBool with to_string(self) {
  self.obj.to_string()
}

pub impl Show for PyBool with output(self, logger) {
  logger.write_string(self.to_string())
}
