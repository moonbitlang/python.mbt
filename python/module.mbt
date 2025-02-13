// ========================================
// Import
// ========================================
pub struct PyModule {
  name: String
  priv obj: PyObject
}

pub fn PyModule::get_obj(self: PyModule) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyModule::get_name(self: PyModule) -> String {
  self.name
}

pub fn pyimport(name: String) -> PyModule? {
  let py_str = PyString::from(name);

  let obj = @cpython.py_import_import(py_str.get_obj());

  let r = if obj.is_null() {
    None
  } else {
    let m = PyModule::{
      name,
      obj: PyObject::create(obj)
    }
    Some(m)
  }

  py_str.drop()
  r
}

pub fn PyModule::get_func(self: PyModule, fname: String) -> PyFunc? {
  let f = @cpython.py_object_get_attr_string(self.get_obj(), fname)

  if f.is_null() {
    return None
  }

  if @cpython.py_function_check(f) {
    Some(PyFunc::create(f))
  } else {
    None
  }
}

pub impl IsPyObject for PyModule with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
} 

