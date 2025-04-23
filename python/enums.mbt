
pub(all) enum PyObjectEnum {
  PyInteger(PyInteger)
  PyFloat(PyFloat)
  PyBool(PyBool)
  PyString(PyString)
  PyList(PyList)
  PyDict(PyDict)
  Custom(PyObject)
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
    PyObjectEnum::Custom(obj)
  }
}

pub fn PyObjectEnum::create_by_ref(obj_ref: @cpython.PyObjectRef) -> PyObjectEnum {
  let obj = PyObject::create(obj_ref);

  PyObjectEnum::create(obj)
}
