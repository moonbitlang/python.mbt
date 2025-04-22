// ========================================
// Dict
// ========================================
pub struct PyDict {
  priv obj: PyObject
}

fn PyDict::obj(self: PyDict) -> PyObject {
  self.obj
}

pub fn PyDict::create(obj: PyObject) -> PyDict!PyRuntimeError {
  guard obj.is_dict() else {
    raise TypeMisMatchError
  }

  PyDict::{ 
    obj: obj
  }
}

pub fn PyDict::create_unchecked(obj: PyObject) -> PyDict {
  PyDict::{ 
    obj: obj
  }
}

pub fn PyDict::create_by_ref(obj: @cpython.PyObjectRef) -> PyDict {
  PyDict::{
    obj: PyObject::create(obj)
  }
}

///| Creates a new python dict object.
///
/// ## Example
///
/// ```moonbit
/// test "PyDict::new" {
///   let dict = PyDict::new()
///            ..set(PyString::from("one"), PyInteger::from(1))
///            ..set(PyString::from("two"), PyFloat::from(2.0))
///            ..set(PyString::from("three"), PyString::from("three"));
///
///   inspect!(dict, content="{\'one\': 1, \'two\': 2.0, \'three\': \'three\'}")
/// }
/// ```
///
/// The above code is equivalent to:
///
/// ```python
/// d = { 'one': 1, 'two': 2.0, 'three': 'three' }
/// 
/// print(d) # Output: {'one': 1, 'two': 2.0, 'three': 'three'}
/// ```
pub fn PyDict::new() -> PyDict {
  PyDict::{
    obj: PyObject::create(@cpython.py_dict_new())
  }
}

///| Return the length of the dict.
///
/// ## Example
///
/// ```moonbit
/// test "PyDict::len" {
///   let dict = PyDict::new()
///        ..set(PyString::from("one"), PyInteger::from(1))
///        ..set(PyString::from("two"), PyFloat::from(2.0))
///        ..set(PyString::from("three"), PyString::from("three"));
///
///   assert_eq!(dict.len(), 3);
/// }
/// ```
pub fn PyDict::len(self: PyDict) -> Int {
  @cpython.py_dict_size(self.obj_ref()).to_int()
}

///| Return the elements of the dict by its key.
///
/// ## Example
///
/// ```moonbit
///
/// ```moonbit
/// test "PyDict::get" {
///   let dict = PyDict::new()
///        ..set("one", PyInteger::from(1))
///        ..set("two", PyFloat::from(2.0))
///        ..set("three", PyString::from("three"));
///
///   inspect!(dict.get("one").unwrap(), content="PyInteger(1)")
///   inspect!(dict.get("two"), content="Some(PyFloat(2.0))")
///   inspect!(dict.get("four"), content="None")
/// }
/// ```
pub fn PyDict::get(self: PyDict, key: String) -> PyObjectEnum? {
  let dict = self.obj_ref()
  let obj_ref = @cpython.py_dict_get_item_string(dict, key)

  @option.when(
    not(obj_ref.is_null()),
    fn () {
      PyObjectEnum::create_by_ref(obj_ref)
    }
  )
}

///| Return the elements of the dict by its key.
///
/// **Note**: Will panic if the key is not found.
///
/// ## Example
///
/// ```moonbit
/// test "PyDict::op_get" {
///   let dict = PyDict::new()
///     ..set("one", PyInteger::from(1))
///     ..set("two", PyFloat::from(2.0))
///     ..set("three", PyString::from("three"));
///
///   inspect!(dict["one"], content="PyInteger(1)")
///   inspect!(dict["two"], content="PyFloat(2.0)")
///   inspect!(dict["three"], content="PyString(\'three\')")
/// }
/// ```
pub fn PyDict::op_get(self: PyDict, key: String) -> PyObjectEnum {
  self.get(key).unwrap()
}

pub fn PyDict::set[V: IsPyObject](self: PyDict, key: String, val: V) -> Unit {
  let dict = self.obj_ref()
  let val = val.obj_ref()
  let _ = @cpython.py_dict_set_item_string(dict, key, val)
}

// TODO: See if it is necessary
// pub fn PyDict::get_by_object
// pub fn PyDict::set_by_object

pub fn PyDict::op_set[V: IsPyObject](self: PyDict, key: String, val: V) -> Unit {
  self.set(key, val)
}

pub fn PyDict::contains(self: PyDict, key: String) -> Bool {
  let dict = self.obj_ref()
  @cpython.py_dict_contains(dict, PyString::from(key).obj_ref())
}

// TODO: Seems that it is incorrect.
pub fn PyDict::keys(self: PyDict) -> PyList {
  PyList::create_by_ref(@cpython.py_dict_keys(self.obj_ref()))
}

pub fn PyDict::values(self: PyDict) -> PyList {
  PyList::create_by_ref(@cpython.py_dict_values(self.obj_ref()))
}

pub fn PyDict::items(self: PyDict) -> PyList {
  PyList::create_by_ref(@cpython.py_dict_items(self.obj_ref()))
}

pub fn PyDict::dump(self: PyDict) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyDict::drop(self: PyDict) -> Unit {
  self.obj.drop()
}

pub fn PyDict::type_name(self: PyDict) -> String {
  self.obj.type_name()
}

pub impl IsPyObject for PyDict with obj(self) {
  self.obj()
}

pub impl Show for PyDict with to_string(self) -> String {
  self.obj.to_string()
}

pub impl Show for PyDict with output(
  self:PyDict, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

