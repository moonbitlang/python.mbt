
// ========================================
// PyInteger
// ========================================
pub struct PyInteger {
  priv obj: PyObject
}

fn PyInteger::get_obj(self: PyInteger) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyInteger::new(value: Int64) -> PyInteger {
  PyInteger::{
    obj: PyObject::create(@cpython.py_long_from_long(value))
  }
}

pub fn PyInteger::to_int64(self: PyInteger) -> Int64 {
  @cpython.py_long_as_long(self.get_obj())
}

pub fn PyInteger::to_double(self: PyInteger) -> Double {
  @cpython.py_long_as_double(self.get_obj())
}

pub fn PyInteger::to_string(self: PyInteger) -> String {
  @cpython.py_object_moonbit_repr(self.get_obj())
}

pub fn PyInteger::dump(self: PyInteger) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyInteger::drop(self: PyInteger) -> Unit {
  self.obj.drop()
}


// ======== Implement Traits ==========
pub impl IsPyObject for PyInteger with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl PyAble for PyInteger with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl Show for PyInteger with to_string(self) -> String {
  PyInteger::to_string(self)
}

pub impl Show for PyInteger with output(
  self:PyInteger, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}
