
// ========================================
// PyInteger
// ========================================
pub struct PyInteger {
  priv obj: PyObject
}

fn PyInteger::obj(self: PyInteger) -> PyObject {
  self.obj
}

pub fn PyInteger::create(obj: PyObject) -> PyInteger {
  PyInteger::{
    obj: obj
  }
}

pub fn PyInteger::new(value: Int64) -> PyInteger {
  PyInteger::{
    obj: PyObject::create(@cpython.py_long_from_long(value))
  }
}

pub fn PyInteger::to_int64(self: PyInteger) -> Int64 {
  @cpython.py_long_as_long(self.obj_ref())
}

pub fn PyInteger::to_double(self: PyInteger) -> Double {
  @cpython.py_long_as_double(self.obj_ref())
}

pub fn PyInteger::to_string(self: PyInteger) -> String {
  @cpython.py_object_moonbit_repr(self.obj_ref())
}

pub fn PyInteger::dump(self: PyInteger) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyInteger::drop(self: PyInteger) -> Unit {
  self.obj.drop()
}

pub fn PyInteger::type_name(self: PyInteger) -> String {
  self.obj.type_name()
}

// ======== Implement Traits ==========
pub impl IsPyObject for PyInteger with obj(self) {
  self.obj()
}

pub impl PyAble for PyInteger with to_pyobject(self) -> PyObject {
  PyObject::create(self.obj_ref())
}

pub impl Show for PyInteger with to_string(self) -> String {
  PyInteger::to_string(self)
}

pub impl Show for PyInteger with output(
  self:PyInteger, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}
