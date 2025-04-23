pub enum PyModuleContent {
  PyCallable(PyFunc)
  PyModule(PyModule)
  PyConstantString(PyString)
  PyConstantInt(PyInteger)
  PyConstantFloat(PyFloat)
  UnKownObject(PyObject)
}

// ========================================
// Import
// ========================================
pub struct PyModule {
  name: String
  obj: PyObject
}

pub fn PyModule::obj(self: PyModule) -> PyObject {
  self.obj
}

pub fn PyModule::obj_ref(self: PyModule) -> @cpython.PyObjectRef {
  self.obj.obj_ref()
}

pub fn PyModule::get_name(self: PyModule) -> String {
  self.name
}

pub fn PyModule::dump(self: PyModule) -> Unit {
  self.obj.dump()
}

pub fn pyimport(name: String, print_err~: Bool = false) -> PyModule? {
  let obj = @cpython.py_import_import_module(name);

  if obj.is_null() {
    if print_err {
      println("module \{name} not found")
      @cpython.py_err_print()
    }
    @cpython.py_err_clear()
    return None
  }

  PyModule::{
    name,
    obj: PyObject::create(obj)
  } |> Some
}


pub fn PyModule::get(self: PyModule, attr: String, print_err~ : Bool = false) -> PyModuleContent? {
  let f = @cpython.py_object_get_attr_string(self.obj_ref(), attr)

  if f.is_null() {
    if print_err {
      println("module \{self.name} has no attribute \{attr}")
      @cpython.py_err_print()
    }
    @cpython.py_err_clear()
    return None
  }

  let c = if @cpython.py_callable_check(f) {
    PyCallable(PyFunc::create_by_ref(f))
  } else if @cpython.py_module_check(f) {
    PyModule(PyModule::{ name: attr, obj: PyObject::create(f) })
  } else if @cpython.py_object_is_string(f) {
    PyConstantString(PyString::create_by_ref_unchecked(f))
  } else if @cpython.py_object_is_int(f) {
    PyConstantInt(PyInteger::create_by_ref_unchecked(f))
  } else if @cpython.py_object_is_float(f) {
    PyConstantFloat(PyFloat::create_by_ref_unchecked(f))
  } else {
    UnKownObject(PyObject::create(f))
  }

  Some(c)
}
