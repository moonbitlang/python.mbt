trait IsPyObject {
  get_obj(Self) -> @cpython.PyObjectRef;
}

trait PyAble {
  to_pyobject(Self) -> PyObject;
}

pub impl PyAble for Int with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_long_from_long(self.to_int64()))
}

pub impl PyAble for Double with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_float_from_double(self))
}

pub impl PyAble for String with to_pyobject(self) -> PyObject {
  PyObject::create(@cpython.py_unicode_from_string(self))
}
