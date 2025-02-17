pub trait IsPyObject {
  obj(Self) -> PyObject;
  obj_ref(Self) -> @cpython.PyObjectRef;
  type_name(Self) -> String;
}

impl IsPyObject with obj_ref(self) {
  self.obj().obj
}

impl IsPyObject with type_name(self) {
  self.obj().type_name()
}

pub trait PyAble {
  to_pyobject(Self) -> PyObject;
  to_pytuple(Self) -> PyTuple;
}

impl PyAble with to_pytuple(self) {
  let obj = self.to_pyobject();
  if @cpython.py_object_is_tuple(obj.obj_ref()) {
    PyTuple::create(obj)
  } else {
    PyTuple::new(1) .. set(0, obj)
  }
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

pub impl[T0: PyAble, T1: PyAble] PyAble for (T0, T1) with to_pyobject(self) {
  let py_tup = PyTuple::new(2)
  py_tup.set(0, self.0)
  py_tup.set(1, self.1)
  py_tup.obj()
}

pub impl[T0: PyAble, T1: PyAble, T2: PyAble] PyAble for (T0, T1, T2) with to_pyobject(self) {
  let py_tup = PyTuple::new(3)
  py_tup.set(0, self.0)
  py_tup.set(1, self.1)
  py_tup.set(2, self.2)
  py_tup.obj()
}

pub impl[T0: PyAble, T1: PyAble, T2: PyAble, T3: PyAble] PyAble for (T0, T1, T2, T3) with to_pyobject(self) {
  let py_tup = PyTuple::new(4)
  py_tup.set(0, self.0)
  py_tup.set(1, self.1)
  py_tup.set(2, self.2)
  py_tup.set(3, self.3)
  py_tup.obj()
}

pub impl[T0: PyAble, T1: PyAble, T2: PyAble, T3: PyAble, T4: PyAble] PyAble for (T0, T1, T2, T3, T4) with to_pyobject(self) {
  let py_tup = PyTuple::new(5)
  py_tup.set(0, self.0)
  py_tup.set(1, self.1)
  py_tup.set(2, self.2)
  py_tup.set(3, self.3)
  py_tup.set(4, self.4)
  py_tup.obj()
}
