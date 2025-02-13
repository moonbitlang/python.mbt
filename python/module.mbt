// ========================================
// Import
// ========================================
pub struct PyModule {
  name: String
  priv obj: PyObject
}

pub fn PyModule::obj_ref(self: PyModule) -> @cpython.PyObjectRef {
  self.obj.obj_ref()
}

pub fn PyModule::get_name(self: PyModule) -> String {
  self.name
}

pub fn pyimport(name: String) -> PyModule? {
  let py_str = PyString::from(name);

  let obj = @cpython.py_import_import(py_str.obj_ref());

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
  let f = @cpython.py_object_get_attr_string(self.obj_ref(), fname)

  if f.is_null() {
    return None
  }

  if @cpython.py_function_check(f) {
    Some(PyFunc::create(f))
  } else {
    None
  }
}

pub impl IsPyObject for PyModule with obj_ref(self) -> @cpython.PyObjectRef {
  self.obj_ref()
} 

