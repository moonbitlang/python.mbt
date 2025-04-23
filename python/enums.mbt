
pub(all) enum PyObjectEnum {
  PyInteger(PyInteger)
  PyFloat(PyFloat)
  PyBool(PyBool)
  PyString(PyString)
  PyList(PyList)
  PyDict(PyDict)
  Class(PyObject)
} derive(Show)

pub fn PyObjectEnum::create(obj: PyObject) -> PyObjectEnum {
  if obj.is_bool() {
    PyObjectEnum::PyBool(PyBool::create_unchecked(obj))
  } else if obj.is_int() {
    PyObjectEnum::PyInteger(PyInteger::create_unchecked(obj))
  } else if obj.is_float() {
    PyObjectEnum::PyFloat(PyFloat::create_unchecked(obj))
  } else if obj.is_string() {
    PyObjectEnum::PyString(PyString::create_unchecked(obj))
  } else if obj.is_list() {
    PyObjectEnum::PyList(PyList::create_unchecked(obj))
  } else if obj.is_dict() {
    PyObjectEnum::PyDict(PyDict::create_unchecked(obj))
  } else {
    PyObjectEnum::Class(obj)
  }
}

pub fn PyObjectEnum::create_by_ref(obj_ref: @cpython.PyObjectRef) -> PyObjectEnum {
  let obj = PyObject::create(obj_ref);

  PyObjectEnum::create(obj)
}

pub enum PyAttrEnum {
  PyCallable(PyCallable)
  PyModule(PyModule)
  PyConstantString(PyString)
  PyConstantInt(PyInteger)
  PyConstantFloat(PyFloat)
  UnKownObject(PyObject)
} derive(Show)

pub fn PyAttrEnum::create_by_ref(obj: @cpython.PyObjectRef) -> PyAttrEnum {
  if @cpython.py_callable_check(obj) {
    PyCallable(PyCallable::create_by_ref(obj))
  } else if @cpython.py_module_check(obj) {
    PyModule(PyModule::{ obj: PyObject::create(obj) })
  } else if @cpython.py_object_is_string(obj) {
    PyConstantString(PyString::create_by_ref_unchecked(obj))
  } else if @cpython.py_object_is_int(obj) {
    PyConstantInt(PyInteger::create_by_ref_unchecked(obj))
  } else if @cpython.py_object_is_float(obj) {
    PyConstantFloat(PyFloat::create_by_ref_unchecked(obj))
  } else {
    UnKownObject(PyObject::create(obj))
  }
}
