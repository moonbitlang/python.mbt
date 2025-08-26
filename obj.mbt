///|
pub struct PyObject {
  priv obj : @cpython.PyObjectRef
}

///|
fn PyObject::obj_ref(self : PyObject) -> @cpython.PyObjectRef {
  self.obj
}

///|
pub fn PyObject::create(obj : @cpython.PyObjectRef) -> PyObject {
  PyObject::{ obj, }
}

///|
pub fn PyObject::is_null(self : PyObject) -> Bool {
  self.obj.is_null()
}

///|
pub fn PyObject::is_bool(self : PyObject) -> Bool {
  @cpython.py_bool_check(self.obj_ref())
}

///|
pub fn PyObject::is_int(self : PyObject) -> Bool {
  @cpython.py_int_check(self.obj_ref())
}

///|
pub fn PyObject::is_float(self : PyObject) -> Bool {
  @cpython.py_float_check(self.obj_ref())
}

///|
pub fn PyObject::is_string(self : PyObject) -> Bool {
  @cpython.py_string_check(self.obj_ref())
}

///|
pub fn PyObject::is_list(self : PyObject) -> Bool {
  @cpython.py_list_check(self.obj_ref())
}

///|
pub fn PyObject::is_tuple(self : PyObject) -> Bool {
  @cpython.py_tuple_check(self.obj_ref())
}

///|
pub fn PyObject::is_dict(self : PyObject) -> Bool {
  @cpython.py_dict_check(self.obj_ref())
}

///|
pub fn PyObject::is_module(self : PyObject) -> Bool {
  @cpython.py_module_check(self.obj_ref())
}

///|
pub fn PyObject::is_callable(self : PyObject) -> Bool {
  @cpython.py_callable_check(self.obj_ref())
}

///|
pub fn PyObject::type_of(self : PyObject) -> PyType {
  if @cpython.py_bool_check(self.obj_ref()) {
    PyType::PyBool
  } else if @cpython.py_int_check(self.obj_ref()) {
    PyType::PyInteger
  } else if @cpython.py_float_check(self.obj_ref()) {
    PyType::PyFloat
  } else if @cpython.py_string_check(self.obj_ref()) {
    PyType::PyString
  } else if @cpython.py_list_check(self.obj_ref()) {
    PyType::PyList
  } else if @cpython.py_tuple_check(self.obj_ref()) {
    PyType::PyTuple
  } else if @cpython.py_dict_check(self.obj_ref()) {
    PyType::PyDict
  } else if @cpython.py_module_check(self.obj_ref()) {
    PyType::PyModule
  } else if @cpython.py_callable_check(self.obj_ref()) {
    PyType::PyCallable
  } else {
    PyType::PyClass
  }
}

///|
pub fn PyObject::dump(self : PyObject) -> Unit {
  @cpython.print_pyobject(self.obj_ref())
}

///|
pub fn PyObject::drop(self : PyObject) -> Unit {
  @cpython.py_decref(self.obj_ref())
}

///|
pub fn PyObject::type_name(self : PyObject) -> String {
  let ty = @cpython.py_type(self.obj_ref())
  let tyname = @cpython.py_type_name(ty)
  tyname
}

///|
pub fn PyObject::get_attr(
  self : PyObject,
  attr : String,
  print_err~ : Bool = false,
) -> PyObjectEnum? {
  let f = @cpython.py_object_get_attr_string(self.obj_ref(), attr)
  if f.is_null() {
    if print_err {
      @cpython.py_err_print()
    }
    @cpython.py_err_clear()
    return None
  }
  let c = PyObjectEnum::create_by_ref(f)
  Some(c)
}

///|
pub impl IsPyObject for PyObject with obj(self) {
  self
}

///|
pub impl Show for PyObject with to_string(self : PyObject) -> String {
  @cpython.py_object_moonbit_str(self.obj)
}

///|
pub impl Show for PyObject with output(self : PyObject, logger : &Logger) -> Unit {
  logger.write_string(self.to_string())
}
