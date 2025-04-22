

pub(all) enum PyObjectEnum {
  PyInteger(PyInteger)
  PyFloat(PyFloat)
  PyString(PyString)
  PyList(PyList)
  Custom(PyObject)
} derive(Show)

pub fn PyObjectEnum::create(obj: PyObject) -> PyObjectEnum {
  if obj.is_int() {
    PyObjectEnum::PyInteger(PyInteger::create_unchecked(obj))
  } else if obj.is_float() {
    PyObjectEnum::PyFloat(PyFloat::create_unchecked(obj))
  } else if obj.is_string() {
    PyObjectEnum::PyString(PyString::create_unchecked(obj))
  } else if obj.is_list() {
    PyObjectEnum::PyList(PyList::create_unchecked(obj))
  } else {
    PyObjectEnum::Custom(obj)
  }
}

pub fn PyObjectEnum::into_integer(self: PyObjectEnum) -> PyInteger!PyRuntimeError {
  guard self is PyInteger(i) else {
    raise TypeMisMatchError
  }

  i
}

pub fn PyObjectEnum::into_float(self: PyObjectEnum) -> PyFloat!PyRuntimeError {
  guard self is PyFloat(f) else {
    raise TypeMisMatchError
  }

  f
}

pub fn PyObjectEnum::into_string(self: PyObjectEnum) -> PyString!PyRuntimeError {
  guard self is PyString(s) else {
    raise TypeMisMatchError
  }

  s
}

pub fn PyObjectEnum::into_list(self: PyObjectEnum) -> PyList!PyRuntimeError {
  guard self is PyList(l) else {
    raise TypeMisMatchError
  }

  l
}
