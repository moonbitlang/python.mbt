// ========================================
// PyString
// ========================================
pub struct PyString {
  priv obj: PyObject
}

pub fn PyString::from(s: String) -> PyString {
  PyString::{
    obj: PyObject::create(@cpython.py_unicode_from_string(s))
  }
}

pub fn PyString::get_obj(self: PyString) -> @cpython.PyObjectRef {
  self.obj.get_obj()
}

pub fn PyString::to_string(self: PyString) -> String {
  PyObject::to_string(self.obj)
}

pub fn PyString::dump(self: PyString) -> Unit {
  PyObject::dump(self.obj)
}

pub fn PyString::drop(self: PyString) -> Unit {
  self.obj.drop()
}

pub impl IsPyObject for PyString with get_obj(self) -> @cpython.PyObjectRef {
  self.get_obj()
}

pub impl PyAble for PyString with to_pyobject(self) -> PyObject {
  PyObject::create(self.get_obj())
}

pub impl Show for PyString with to_string(self) -> String {
  PyString::to_string(self)
}

pub impl Show for PyString with output(
  self:PyString, logger: &Logger
) -> Unit {
  logger.write_string(self.to_string())
}

